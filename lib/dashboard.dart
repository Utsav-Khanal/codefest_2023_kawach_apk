import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kawach_apk/login_page.dart';
import 'callSmsModule.dart';
import 'package:kawach_apk/user_controller.dart';
import 'package:kawach_apk/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? userName;
  String? emergencyContact1;
  String? emergencyContact2;

  @override
  void initState() {
    super.initState();

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('User Registration')
          .doc(user!.uid)
          .get();

      setState(() {
        userName = userData['fullname'];
        emergencyContact1 = userData['ephone1'];
        emergencyContact2 = userData['ephone2'];
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginPage());
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(78, 190, 195, 1),
        centerTitle: true,
        title: Text("कवच"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Section 1: User Name and Logo
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    userName ?? "",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/kawach_logo.png',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),

          SizedBox(
            height: 30,
          ),

          // Section 2: Emergency Contact List
          Expanded(
            child: Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text("आपतकालीन सम्पर्क नम्बर"),
                    subtitle: Text(emergencyContact1 ?? "Not provided"),
                  ),
                  ListTile(
                    title: Text("दोस्रो आपतकालीन सम्पर्क नम्बर"),
                    subtitle: Text(emergencyContact2 ?? "Not provided"),
                  ),
                  // Add more ListTile widgets for additional contacts
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 75,
            left: 30,
            child: FloatingActionButton(
              onPressed: () {
                // Use Get.toNamed to navigate to the CameraPage
                Get.toNamed(MyRoutes.cameraRoute);
              },
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              child: Image.asset(
                'assets/images/camera.png',
                width: 50,
                height: 45,
              ),
            ),
          ),
          Positioned(
            bottom: 75,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                // Open the CallSmsModule when the siren button is pressed
                Get.to(CallSmsModule(
                  emergencyContact1: emergencyContact1,
                  emergencyContact2: emergencyContact2,
                ));
              },
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              child: Image.asset(
                'assets/images/siren.png',
                width: 50,
                height: 45,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
