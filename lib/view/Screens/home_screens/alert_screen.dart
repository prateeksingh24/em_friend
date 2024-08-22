import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_friend/utilities/live_location.dart';
import 'package:em_friend/utilities/route_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vibration/vibration.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS Log',
      home: SOSScreen(),
    );
  }
}

class SOSScreen extends StatefulWidget {
  @override
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  double containerHeight = 200.0;
  bool _sosSignal = false;
  @override
  void initState() {
    super.initState();
    // Start a timer to periodically shrink and expand the container

    Timer.periodic(Duration(seconds: 2), (timer) {
      Vibration.vibrate(
        duration: 500,
      );
      if (_sosSignal) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Log'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SOS Log',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  _sosSignal = true;
                  Position _currentPos =
                      await LiveLocation().getCurrentLocation();
                  final _firestore = FirebaseFirestore.instance;
                  print('object 123');
                  final doc = await _firestore
                      .collection("EMSignal")
                      .doc('Emergency')
                      .get();
                  print('object 456');
                  final data = doc.data()!;
                  final docDest = await _firestore
                      .collection('Users')
                      .doc(data['uid'])
                      .get();
                  print(docDest);
                  print('object 567');

                  // final dataUser = docDest.data();
                  // print(dataUser);
                  // final GeoPoint destination = dataUser!['liveLocation'];
                  // print('object 123');25.067096630093186, 75.79820563885629
                  LatLng dest = LatLng(25.067096630093186, 75.79820563885629);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => RoutePage(
                        origin:
                            LatLng(_currentPos.latitude, _currentPos.longitude),
                        dest: dest,
                      ),
                    ),
                  );
                },
                child: Text(
                  "EMERGENCY !!!!",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
