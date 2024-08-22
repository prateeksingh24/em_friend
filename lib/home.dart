import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:em_friend/view/Screens/home_screens/alert_screen.dart';
import 'package:em_friend/view/Screens/home_screens/homePage.dart';
import 'package:em_friend/view/Screens/home_screens/sosPage.dart';
import 'package:em_friend/view/Screens/home_screens/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomNavIndex = 0; // Assuming you have initialized _bottomNavIndex

  List<IconData> iconList = [
    Icons.home,
    Icons.access_alarms_rounded,
    Icons.notifications,
    Icons.settings,
  ];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   ShakeDetector detector = ShakeDetector.autoStart(
  //     onPhoneShake: () {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Shake!'),
  //         ),
  //       );
  //       // Do stuff on phone shake
  //     },
  //     minimumShakeCount: 1,
  //     shakeSlopTimeMS: 500,
  //     shakeCountResetTime: 3000,
  //     shakeThresholdGravity: 2.7,
  //   );
  //
  // }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: _getBody(_bottomNavIndex),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SosPage()),
          );
        },
        shape: CircleBorder(),
        child: Image.asset(
          'assets/logos/emergencyAppLogo.png',
          width: 20,
          height: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return IconButton(
            color: isActive ? Colors.blue : Colors.grey,
            onPressed: () {
              setState(() {
                _bottomNavIndex = index;
              });
            },
            icon: Icon(iconList[index], size: 24),
          );
        },
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (int) {},
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return StreamCheck();
      case 2:
        return NotificationScreen();
      case 3:
        return SettingScreen();
      default:
        return Container();
    }
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home Screen"),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Notification Screen"),
    );
  }
}

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Setting Screen"),
    );
  }
}
