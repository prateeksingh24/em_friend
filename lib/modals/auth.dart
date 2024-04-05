import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authenticate {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    String res = "error is there";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        final sak = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(sak);
        res = "success";
      } else {
        res = "Please Fill All the Details";
      }
    } on FirebaseAuthException catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> signUp(String email, String password) async {
    String res = "error is there";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        final sak = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please Fill All the Details";
      }
    } on FirebaseAuthException catch (err) {
      res = err.toString();
    }

    return res;
  }
}
