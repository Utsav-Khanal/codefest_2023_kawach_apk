import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kawach_apk/routes.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController ephone1 = TextEditingController();
  TextEditingController ephone2 = TextEditingController();
  TextEditingController imei = TextEditingController();
  TextEditingController password = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  late ScaffoldMessengerState scaffoldMessenger;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Image.asset(
                  "assets/images/kawach_logo.png",
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "कवच एपमा स्वागत छ",
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
                              controller: fullname,
                              decoration: InputDecoration(
                                hintText: "पुरा नाम हाल्नुहोस",
                                labelText: "पुरा नाम",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(153, 129, 123, 123),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              validator: (value) {
                                final RegExp nameRegExp =
                                    RegExp(r'^[zaA-zZ\s]+$');
                                if (value?.isEmpty ?? true) {
                                  return "नाम खाली हुन भएन";
                                } else if (!nameRegExp.hasMatch(value!)) {
                                  return "कृपया मात्र अक्षर र स्पेस प्रयोग गर्नुहोस्";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                            ),
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                hintText: "इमेल हाल्नुहोस",
                                labelText: "इमेल",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(153, 129, 123, 123),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              validator: (value) {
                                final RegExp emailRegExp = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
                                );
                                if (value?.isEmpty ?? true) {
                                  return "इमेल खाली हुन भएन";
                                } else if (!emailRegExp.hasMatch(value!)) {
                                  return ("कृपया इमेल चेक गर्नुहोस्");
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                            ),
                            TextFormField(
                              controller: phone,
                              decoration: InputDecoration(
                                hintText: "मोबाईल नम्बर हाल्नुहोस",
                                labelText: "मोबाईल नम्बर",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(153, 129, 123, 123),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "मोबाइल नम्बर खाली हुन भएन";
                                }
                                final numericRegExp = RegExp(r'^[0-9]+$');

                                if (!numericRegExp.hasMatch(value!)) {
                                  return "कृपया मोबाइल नम्बर चेक गर्नुहोस्";
                                }

                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                            ),
                            TextFormField(
                              controller: ephone1,
                              decoration: InputDecoration(
                                hintText: "आपतकालीन सम्पर्क नम्बर हाल्नुहोस",
                                labelText: "आपतकालीन सम्पर्क नम्बर",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(153, 129, 123, 123),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "आपतकालीन सम्पर्क नम्बर खाली हुन भएन";
                                }
                                final numericRegExp = RegExp(r'^[0-9]+$');

                                if (!numericRegExp.hasMatch(value!)) {
                                  return "आपतकालीन सम्पर्क चेक गर्नुहोस्";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                            ),
                            TextFormField(
                              controller: ephone2,
                              decoration: InputDecoration(
                                hintText:
                                    "दोस्रो आपतकालीन सम्पर्क नम्बर हाल्नुहोस",
                                labelText: "दोस्रो आपतकालीन सम्पर्क नम्बर",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(153, 129, 123, 123),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "दोस्रो आपतकालीन सम्पर्क नम्बर खाली हुन भएन";
                                }
                                final numericRegExp = RegExp(r'^[0-9]+$');

                                if (!numericRegExp.hasMatch(value!)) {
                                  return "दोस्रो आपतकालीन सम्पर्क चेक गर्नुहोस्";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                            ),
                            TextFormField(
                              controller: imei,
                              decoration: InputDecoration(
                                hintText: "IMEI नम्बर हाल्नुहोस",
                                labelText: "IMEI नम्बर",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(153, 129, 123, 123),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "IMEI नम्बर खाली हुन भएन";
                                }

                                final numericRegExp = RegExp(r'^[0-9]+$');

                                if (!numericRegExp.hasMatch(value!)) {
                                  return "IMEI नम्बर चेक गर्नुहोस्";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                            ),
                            TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "पासवर्ड हल्नुहोस",
                                labelText: "पासवर्ड",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(153, 129, 123, 123),
                                  fontWeight: FontWeight.bold,
                                ),
                                alignLabelWithHint: true,
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "पासवर्ड खाली हुन भएन";
                                } else if (value!.length < 5) {
                                  return "पासवर्डको लम्बाइ कम्तिमा 5 हुनुपर्छ";
                                }

                                final upperCaseRegExp = RegExp(r'[A-Z]');
                                final numericRegExp = RegExp(r'[0-9]');
                                final specialCharRegExp =
                                    RegExp(r'[!@#$%^&*()]');

                                if (!upperCaseRegExp.hasMatch(value) ||
                                    !numericRegExp.hasMatch(value) ||
                                    !specialCharRegExp.hasMatch(value)) {
                                  return "पासवर्डमा एउटा क्यापिटल,नम्बर र एउटा विशेष क्यारेक्टर हुनुपर्छ";
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var fullName = fullname.text.trim();
                            var emailAddress = email.text.trim();
                            var mobile = phone.text.trim();
                            var emergencyPhone1 = ephone1.text.trim();
                            var emergencyPhone2 = ephone2.text.trim();
                            var imeiNumber = imei.text.trim();
                            var pass = password.text.trim();

                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                email: emailAddress,
                                password: pass,
                              );

                              // Here, you should use the .text property of the controllers
                              await FirebaseFirestore.instance
                                  .collection("User Registration")
                                  .doc(userCredential.user!.uid)
                                  .set({
                                'fullname': fullName,
                                'email': emailAddress,
                                'phone': mobile,
                                'ephone1': emergencyPhone1,
                                'ephone2': emergencyPhone2,
                                'imei': imeiNumber,
                                'createdAt': DateTime.now(),
                                'userId': userCredential.user!.uid,
                              });

                              // Show a success message using a global SnackBar
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text("दर्ता सफल भयो"),
                                  duration: Duration(seconds: 5),
                                ),
                              );

                              // Redirect to the login page
                              Navigator.pushNamed(context, '/login');
                            } catch (e) {
                              // Handle registration errors, if any, using a global SnackBar
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text("Registration failed: $e"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 78, 190, 195),
                            fixedSize: Size(150, 50)),
                        child: Text(
                          'दर्ता गर्नुहोस् ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 78, 190, 195),
                          fixedSize: Size(140, 50),
                        ),
                        child: Text(
                          'लगइन गर्नुहोस ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
      ),
    );
  }
}
