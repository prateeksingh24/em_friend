import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> emergencies = [
    "Police",
    "Hospital",
    "Fire Brigade",
    "Ambulance"
  ];
  final List img = [
    "assets/logos/policeman.png",
    "assets/logos/hospital.png",
    "assets/logos/fire-brigade.png",
    "assets/logos/ambulance.png"
  ];
  int _bottomNavIndex = 0; // Assuming you have initialized _bottomNavIndex

  List<IconData> iconList = [
    Icons.home,
    Icons.search,
    Icons.notifications,
    Icons.settings,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.09),
          child: Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image:
                          const AssetImage("assets/logos/emergencyAppLogo.png"),
                      height: Get.height * 0.08,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        "Emergencies",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.only(top:60),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(10),
          children: List.generate(4, (index) {
            return Container(
              padding: const EdgeInsets.all(30),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Image.asset(
                    img[index],
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(emergencies[index]),
                ],
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        shape: CircleBorder(),
        child:Image.asset('assets/logos/emergencyAppLogo.png',width: 20,height: 20,) ,
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Icon(
            iconList[index],
            size: 24,
            color: isActive ? Colors.blue : Colors.grey, // Adjust colors as needed
          );
        },
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
