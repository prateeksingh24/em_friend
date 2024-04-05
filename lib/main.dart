import 'package:em_friend/live_location.dart';
import 'package:em_friend/route_map.dart';
import 'package:em_friend/view/Screens/auth/login_screen.dart';
import 'package:em_friend/view/Screens/auth/signup_screeen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
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
      home:LoginScreen(),
      routes: {
        '/home':(context)=> Home(),
        '/loginScreen':(context)=>LoginScreen(),
        '/signUpScreen':(context)=>SignUpScreen(),
      },
    );
  }
}
