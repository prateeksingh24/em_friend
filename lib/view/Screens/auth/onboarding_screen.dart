import 'package:em_friend/view/Screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

import '../../../Controller/widgets/utils/AppColor.dart';

class OnboardingScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Emergency Patrol',
      subTitle: 'Our app provides a platform for quick response services from police, ambulance, and firefighters.',
      imageUrl: 'assets/Ambulance.png',
      titleTextStyle: TextStyle(
        fontSize:20,
        fontWeight: FontWeight.w600,
      ),
      subTitleTextStyle: TextStyle(
        fontSize: 15,
      ),
    ),
    Introduction(
      title: 'Easy and Fast Response',
      subTitle: 'Our app allows you to quickly send out an emergency request with just a few taps, and our responders will be alerted to your location within seconds.',
      imageUrl: 'assets/Quick.png',
      titleTextStyle: TextStyle(
        fontSize:20,
        fontWeight: FontWeight.w600,
      ),
      subTitleTextStyle: TextStyle(
        fontSize: 15,
      ),
    ),
    Introduction(
      title: 'Choose Your Responder',
      subTitle: 'Responders can select their expertise and availability, helping citizens find available help for emergency requests',
      imageUrl: 'assets/Choose.png',
      titleTextStyle: TextStyle(
        fontSize:20,
        fontWeight: FontWeight.w600,
      ),
      subTitleTextStyle: TextStyle(
        fontSize: 15,
      ),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      skipTextStyle: TextStyle(
        color: AppColors.kPrimary,
      ),
      foregroundColor: AppColors.kPrimary,
        introductionList: list,
        onTapSkipButton: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ), //MaterialPageRoute
          );
        }
    );
  }
}
