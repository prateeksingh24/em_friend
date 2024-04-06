import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_friend/view/Screens/home_screens/alert_screen.dart';
import 'package:em_friend/view/Screens/home_screens/sosPage.dart';
import 'package:flutter/material.dart';

class StreamCheck extends StatefulWidget {
  const StreamCheck({super.key});

  @override
  State<StreamCheck> createState() => _StreamCheckState();
}

class _StreamCheckState extends State<StreamCheck> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("EMSignal")
          .doc('Emergency')
          .snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.active) {
          if (snap.hasData && snap.data!.exists) {
            final data = snap.data!.data() as Map<String, dynamic>;
            final isEmergency = data['emergency'] ?? false;
            if (isEmergency) {
              return SOSScreen();
            } else {
              return Scaffold(
                  appBar: AppBar(
                    title: Text("Monitor Screen"),
                    centerTitle: true,
                    backgroundColor: Color.fromARGB(255, 75, 174, 255),
                  ),
                  body: Center(child: Text("Everyone is safe and Sound :)")));
            }
          }
        }
        if (snap.connectionState == ConnectionState.waiting) {
          return Container(
            child: Container(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(),
            ),
          );
        }
        // Default UI
        return Scaffold(
          appBar: AppBar(
            title: Text("Monitor Screen"),
          ),
          body: Container(),
        );
      },
    );
  }
}
