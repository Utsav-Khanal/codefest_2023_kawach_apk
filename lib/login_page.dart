import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kawach_apk/forgetPd.dart';
import 'package:kawach_apk/dashboard.dart';
import 'package:kawach_apk/user_controller.dart'; // Import your UserController

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPassController = TextEditingController();

  String? emailError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
              ),
              Image.asset(
                "assets/images/kawach_logo.png",
                height: 190,
                width: 200,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "कवच एपम स्वागत छ",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(78, 190, 195, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: loginEmailController,
                            decoration: InputDecoration(
                              hintText: "इमेल हाल्नुहोस",
                              labelText: "इमेल",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(153, 129, 123, 123),
                                fontWeight: FontWeight.bold,
                              ),
                              errorText: emailError,
                            ),
                            validator: (value) {
                              final RegExp emailRegExp = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
                              );
                              if (value?.isEmpty ?? true) {
                                return "इमेल खाली हुन भएन";
                              } else if (!emailRegExp.hasMatch(value!)) {
                                return "कृपया इमेल चेक गर्नुहोस्";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: loginPassController,
                            decoration: InputDecoration(
                              hintText: "पासवर्ड हल्नुहोस",
                              labelText: "पासवर्ड",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(153, 129, 123, 123),
                                fontWeight: FontWeight.bold,
                              ),
                              alignLabelWithHint: true,
                              errorText: passwordError,
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "पासवर्ड खाली हुन भएन";
                              } else if (value!.length < 5) {
                                return "पासवर्डको लम्बाइ कम्तिमा 5 हुनुपर्छ";
                              }

                              final upperCaseRegExp = RegExp(r'[A-Z]');
                              final numericRegExp = RegExp(r'[0-9]');
                              final specialCharRegExp = RegExp(r'[!@#$%^&*()]');

                              if (!upperCaseRegExp.hasMatch(value) ||
                                  !numericRegExp.hasMatch(value) ||
                                  !specialCharRegExp.hasMatch(value)) {
                                return "कृपया पासवर्ड चेक गर्नुहोस्";
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 78, 190, 195),
                        fixedSize: Size(150, 50),
                      ),
                      onPressed: () async {
                        setState(() {
                          emailError = null;
                          passwordError = null;
                        });

                        if (_formKey.currentState!.validate()) {
                          var loginEmail = loginEmailController.text.trim();
                          var loginPassword = loginPassController.text.trim();

                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: loginEmail,
                              password: loginPassword,
                            );

                            // Fetch user data and store it using UserController
                            await UserController().fetchUserData();

                            // Navigate to the DashboardPage
                            Get.off(() => DashboardPage());
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found' ||
                                e.code == 'wrong-password') {
                              setState(() {
                                emailError = "इमेल वा पासवर्ड मिलेन";
                                passwordError = "इमेल वा पासवर्ड मिलेन";
                              });
                            }
                            print("Error $e");
                          }
                        }
                      },
                      child: Text(
                        'लगइन',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    Material(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => forgetPd());
                        },
                        child: Container(
                          width: 142,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "पासवर्ड बिर्सिनुभयो",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 78, 190, 195),
                        fixedSize: Size(140, 50),
                      ),
                      child: Text(
                        'दर्ता गर्नुहोस्',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
