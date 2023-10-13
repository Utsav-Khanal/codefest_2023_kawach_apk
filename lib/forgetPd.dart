import 'package:flutter/material.dart';
import 'package:kawach_apk/login_page.dart';
import 'package:kawach_apk/login_page.dart';
import 'package:kawach_apk/registereuser.dart';
import 'package:kawach_apk/routes.dart';

class forgetPd extends StatefulWidget {
  @override
  State<forgetPd> createState() => _forgetPdState();
}

class _forgetPdState extends State<forgetPd> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  moveToOtp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });

      await Navigator.pushNamed(context, MyRoutes.forgetRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFE5E5E5),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 120.0,
              ),
              Image.asset(
                "assets/images/kawach_logo.png",
                height: 200,
                width: 200,
              ),
              Material(
                color: Color(0xFFE5E5E5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Container(
                    width: 142,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "< पछाडी जानुहोस्",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () => moveToOtp(context),
                        child: Container(
                          width: changeButton ? 50 : 150,
                          height: 50,
                          alignment: Alignment.center,
                          color: Color.fromARGB(255, 78, 190, 195),
                          child: changeButton
                              ? Icon(Icons.done)
                              : Text(
                                  "अगाडि बढ्नुहोस",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
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
