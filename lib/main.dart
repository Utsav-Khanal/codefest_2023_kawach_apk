import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kawach_apk/callSmsModule.dart';

import 'package:kawach_apk/cameraPage.dart';
import 'package:kawach_apk/dashboard.dart';
// import 'package:kawach_app/firebase_options.dart';
import 'package:kawach_apk/forgetPd.dart';
import 'package:kawach_apk/indexpage.dart';
import 'package:kawach_apk/login_page.dart';
import 'package:kawach_apk/registereuser.dart';
import 'package:kawach_apk/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  DateTime? currentBackPressTime; // To track the back button press time

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Future<bool> onWillPop() async {
    // Handle back button presses
    if (user != null) {
      // If the user is logged in, navigate to the DashboardPage
      Get.to(() => DashboardPage());
      return false; // Do not exit the app
    } else {
      // If the user is not logged in, exit the app
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        Get.snackbar(
          'Press back again to exit',
          'Pressing back again will close the app',
        );
        return Future.value(false);
      }
      return Future.value(true); // Exit the app
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: user != null ? DashboardPage() : LoginPage(),

      // Wrap the home widget with WillPopScope
      builder: (BuildContext context, Widget? child) {
        return WillPopScope(
          onWillPop: onWillPop,
          child: child!,
        );
      },

      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => IndexPage()),
        GetPage(name: MyRoutes.indexRoute, page: () => IndexPage()),
        GetPage(name: MyRoutes.loginRoute, page: () => LoginPage()),
        GetPage(name: MyRoutes.registerRoute, page: () => RegisterPage()),
        GetPage(name: MyRoutes.homeRoute, page: () => DashboardPage()),
        GetPage(name: MyRoutes.cameraRoute, page: () => CameraPage()),
        GetPage(name: MyRoutes.forgetRoute, page: () => forgetPd()),
        GetPage(name: MyRoutes.callSmsRoute, page: () => CallSmsModule()),
      ],
    );
  }
}
