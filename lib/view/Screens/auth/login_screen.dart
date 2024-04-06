import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_friend/modals/auth.dart';
import 'package:em_friend/modals/general_info.dart';
import 'package:em_friend/utilities/live_location.dart';
import 'package:em_friend/utilities/push_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../Controller/widgets/objects/authField.dart';
import '../../../Controller/widgets/objects/customTextButton.dart';
import '../../../Controller/widgets/objects/primary_button.dart';
import '../../../Controller/widgets/objects/remeberCheckBox.dart';
import '../../../Controller/widgets/objects/socialButton.dart';
import '../../../Controller/widgets/utils/AppAssets.dart';
import '../../../Controller/widgets/utils/AppColor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRemember = false;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kLightWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Text(
                "Welcome back! Please enter your details",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 90,
              ),
              AuthField(
                  controller: _mailController,
                  keyboardType: TextInputType.emailAddress,
                  icon: AppAssets.kMail,
                  iconColor: AppColors.kLavender,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!_isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                  hintText: 'Email Address'),
              const SizedBox(
                height: 10,
              ),
              AuthField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  icon: AppAssets.kLock,
                  iconColor: AppColors.kPeriwinkle,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (!_isPasswordStrong(value)) {
                      return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.';
                    }
                    return null;
                  },
                  hintText: 'Password'),
              const SizedBox(
                height: 20,
              ),
              RememberCheckBox(
                onRememberChanged: (value) {
                  setState(() {
                    isRemember = value;
                  });
                },
              ),
              const SizedBox(
                height: 70,
              ),
              CustomTextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform the 'Forget Password' logic here
                    print("Forget Password clicked");
                  }
                },
                text: "Forget Password",
              ),
              const SizedBox(
                height: 10,
              ),
              PrimaryButton(
                onTap: () async {
                  if (_formKey.currentState!.validate() && !isLoading) {
                    // Form is valid, perform the 'Sign In' logic here
                    setState(() {
                      isLoading = true;
                    });
                    await LiveLocation().requestPermission();
                    Position _position =
                        await LiveLocation().getCurrentLocation();
                    String token =
                        await PushNotification().setupPopNotifications();

                    await PushGI().GIupdate(_position, token);

                    final response = await Authenticate()
                        .login(_mailController.text, _passwordController.text);
                    await LiveLocation().requestPermission();
                    await PushNotification().setupPopNotifications();

                    setState(() {
                      isLoading = false;

                      if (response == "success") {
                        Navigator.pushNamed(context, '/home');

                        print("Sign In Completed");
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        SnackBar(content: Text(response));
                      }
                    });
                  }
                },
                text: isLoading ? 'Signing In...' : 'Sign In',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'Create account',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    onTap: () => Navigator.pushNamed(context, '/signUpScreen'),
                    text: 'Sign Up',
                    width: 70,
                    height: 30,
                    fontColor: AppColors.kPrimary,
                    btnColor: AppColors.kLightWhite2,
                    fontSize: 12,
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(onTap: () {}, icon: AppAssets.kGoogle),
                  const SizedBox(width: 31),
                  SocialButton(onTap: () {}, icon: AppAssets.kFacebook),
                  const SizedBox(width: 31),
                  SocialButton(onTap: () {}, icon: AppAssets.kApple),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

bool _isValidEmail(String email) {
  // Regular expression for a basic email validation
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
  );

  return emailRegExp.hasMatch(email);
}

bool _isPasswordStrong(String password) {
  if (password.length < 8) {
    return false;
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return false;
  }
  return true;
}
