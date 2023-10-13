import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async'; // Import for Timer
import 'call.dart';

class CallSmsModule extends StatefulWidget {
  final String? emergencyContact1;
  final String? emergencyContact2;

  CallSmsModule({this.emergencyContact1, this.emergencyContact2});

  @override
  _CallSmsModuleState createState() => _CallSmsModuleState();
}

class _CallSmsModuleState extends State<CallSmsModule> {
  List<String> phoneNumbers = [];
  int currentPhoneNumberIndex = 0;
  Timer? callTimer;

  Future<String> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      default:
        break;
    }
  }

  Future<void> requestSmsPermission() async {
    final status = await Permission.sms.request();
    switch (status) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      default:
        break;
    }
  }

  void initiateCommunication() async {
    if (phoneNumbers.isNotEmpty) {
      String phoneNumber = phoneNumbers[currentPhoneNumberIndex];
      await requestLocationPermission();
      await requestSmsPermission();

      String senderLocation = await getCurrentLocation();
      String message = 'Help Help Help from $senderLocation!';

      // Use Future.wait to send SMS and make the call concurrently
      await Future.wait([
        sendSMS(message: message, recipients: [phoneNumber], sendDirect: true),
        CallHelper.callPhoneNumber(phoneNumber),
      ]);

      currentPhoneNumberIndex =
          (currentPhoneNumberIndex + 1) % phoneNumbers.length;
    }
  }

  void startCallingLoop() {
    // Start a timer to loop the calling process for 5 minutes
    callTimer = Timer.periodic(Duration(seconds: 15), (timer) {
      if (timer.tick < (5 * 60 / 15)) {
        // Call first emergency contact number
        initiateCommunication();
      } else {
        // After 5 minutes, cancel the timer
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the phoneNumbers list with the passed emergency contact numbers
    phoneNumbers = [
      widget.emergencyContact1 ?? '',
      widget.emergencyContact2 ?? ''
    ];

    // Automatically initiate communication when the app runs
    initiateCommunication();

    // Start the calling loop
    startCallingLoop();
  }

  @override
  void dispose() {
    // Dispose of the timer when the widget is disposed
    callTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CallSmsModule'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Auto-initiating communication...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
