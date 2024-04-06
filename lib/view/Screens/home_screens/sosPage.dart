import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_friend/utilities/live_location.dart';
import 'package:em_friend/utilities/route_map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:em_friend/dependency/latlngz.dart';
import 'package:latlong2/latlong.dart';

// import 'package:flutter_sms/flutter_sms.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  void callSOS() async {
    final _firestore = FirebaseFirestore.instance;
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final snap = await _firestore
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Position _currentPos = await LiveLocation().getCurrentLocation();
    await _firestore
        .collection("EMSignal")
        .doc('Emergency')
        .update({'emergency': true, 'uid': userUid});
    GeoPoint currentLoc = GeoPoint(_currentPos.latitude, _currentPos.longitude);
    LatLng dest = LatLng(28.3642546499153, 75.60845071623878);
  
    Navigator.push(context,MaterialPageRoute(
      builder: (context) => RoutePage(
        origin: LatLng(currentLoc.latitude, currentLoc.longitude),
        dest: dest,
      ),
    ),);
    Timer.periodic(Duration(seconds: 15), (timer) async {
      final documentSnap =
          await _firestore.collection("Users").doc(userUid).get();
      final data = documentSnap.data()!;
      _currentPos = await LiveLocation().getCurrentLocation();
      data['liveLocation'] =
          GeoPoint(_currentPos.latitude, _currentPos.longitude);
      print(data['liveLocation']);
      await _firestore.collection("Users").doc(userUid).update(data);
    });

  }

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 140,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(70)),
                child: Center(
                  child: TextButton(
                    child: Text(
                      'SOS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: callSOS,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Press the button to send your location to the \nrescue headquarters and send distress sms to \nyour emergency contacts",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

//
// void _sendSMS(String message, List<String> recipents) async {
//   String _result = await sendSMS(message: message, recipients: recipents)
//       .catchError((onError) {
//     print(onError);
//   });
//   print(_result);
// }