import 'dart:ui';

import 'package:em_friend/dependency/firebase_options.dart';
import 'package:em_friend/utilities/live_location.dart';
import 'package:em_friend/utilities/route_map.dart';
import 'package:em_friend/view/Screens/Forms/generalInfo.dart';
import 'package:em_friend/view/Screens/auth/login_screen.dart';
import 'package:em_friend/view/Screens/auth/signup_screeen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/loginScreen',
      routes: {
        '/home': (context) => Home(),
        '/loginScreen': (context) => LoginScreen(),
        '/signUpScreen': (context) => SignUpScreen(),
        '/infoForm': (context) => GeneralInfoForm(),
      },
    );
  }
}
