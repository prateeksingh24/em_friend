import 'package:em_friend/view/Screens/home_screens/police.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    children: [
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
        padding: const EdgeInsets.only(top: 60),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(10),
          children: List.generate(4, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PoliceOption()));
              },
              child: Container(
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
              ),
            );
          }),
        ),
      ),
    );
  }
}
