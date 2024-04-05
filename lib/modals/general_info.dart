import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeneralInfo {
  GeneralInfo({
    required this.name,
    required this.DOB,
    required this.address,
    required this.city,
    required this.pincode,
    required this.medicalCondition,
  });
  final String name;
  final String DOB;
  final String address;
  final String city;
  final String pincode;
  final String medicalCondition;
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'DOB': DOB,
      'address': address,
      'city': city,
      'pincode': pincode,
      'medicalCondition': medicalCondition,
    };
  }
}

class PushGI {
  PushGI({required this.selfBio});
  final GeneralInfo selfBio;
  final _firestore = FirebaseFirestore.instance;

  Future<String> GIsignIn() async {
    String res = "fail";
    await _firestore
        .collection("GeneralInfo")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(selfBio.toMap());
    res = "pass";
    return res;
  }
}
