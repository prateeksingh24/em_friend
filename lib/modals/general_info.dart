import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class GeneralInfo {
  GeneralInfo({
    required this.name,
    required this.DOB,
    required this.address,
    required this.city,
    required this.pincode,
    required this.medicalCondition,
    required this.uid,
    required this.liveLocation,
    required this.token,
  });
  final String name;
  final String DOB;
  final String address;
  final String city;
  final String pincode;
  final String medicalCondition;
  final String uid;
  final GeoPoint liveLocation;
  final String token;
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'DOB': DOB,
      'address': address,
      'city': city,
      'pincode': pincode,
      'medicalCondition': medicalCondition,
      'liveLocation': liveLocation,
      'token': token,
    };
  }
}

class PushGI {
  final _firestore = FirebaseFirestore.instance;

  Future<String> GIsignIn(GeneralInfo selfBio) async {
    String res = "error";
    try {
      await _firestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(selfBio.toMap());
      res = "pass";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> GIupdate(Position position, String token) async {
    String res = "error";
    try {
      final documentSnap = await _firestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final data = documentSnap.data()!;
      print(data);
      data['liveLocation'] = GeoPoint(position.latitude, position.longitude);
      data['token'] = token;
      print(data);

      await _firestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data);

      res = "pass";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
