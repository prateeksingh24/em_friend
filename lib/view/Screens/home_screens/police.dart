import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoliceOption extends StatefulWidget {
  const PoliceOption({Key? key}) : super(key: key);

  @override
  State<PoliceOption> createState() => _PoliceOptionState();
}

class _PoliceOptionState extends State<PoliceOption> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
          preferredSize: Size.fromHeight(screenHeight * 0.09),
          child: Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/logos/emergencyAppLogo.png"),
                      height: screenHeight * 0.08,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Police Options",
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10),

            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
              borderRadius: BorderRadius.circular(10),


            ),
            child: Row(
              children: [
                Icon(Icons.map,color: Colors.yellow,),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Text("Police Station Map Display",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),),
                    Text("Find the nearest Police Station on the map",style: TextStyle(color: Colors.white),)
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10),

            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
              borderRadius: BorderRadius.circular(10),


            ),
            child: Row(
              children: [
                Icon(Icons.call,color: Colors.yellow,),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Text("Call Police Station Helpline",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),),
                    Text("Direct call the poilice Station helpline",style: TextStyle(color: Colors.white),)
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10),

            height: 80,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),


            ),
            child: Row(
              children: [
                Icon(Icons.message,color: Colors.white,),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Text("Send Direct Map Display",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),),
                    Text("Send a distress message to emergency \n contacts",style: TextStyle(color: Colors.white),)
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
