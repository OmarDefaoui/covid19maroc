import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthService {
  static Future<bool> login(
      BuildContext context, String email, String password) async {
    bool success = false;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .whenComplete(() {
      success = true;
    }).catchError((error) {
      success = false;
      print('error in login: $error');
    });

    if (success) {
      return true;
    } else
      return false;
  }

  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
