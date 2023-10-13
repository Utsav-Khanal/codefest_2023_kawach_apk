import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  static final UserController _instance = UserController._internal();

  factory UserController() {
    return _instance;
  }

  UserController._internal();

  String? userName;
  String? emergencyContact1;
  String? emergencyContact2;

  Future<void> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('User Registration')
          .doc(user!.uid)
          .get();

      userName = userData['fullname'];
      emergencyContact1 = userData['ephone1'];
      emergencyContact2 = userData['ephone2'];
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}
