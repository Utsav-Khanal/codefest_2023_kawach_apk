import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallHelper {
  static Future<void> callPhoneNumber(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }
}
