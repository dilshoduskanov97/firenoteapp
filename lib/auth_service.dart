import 'package:firebase_auth/firebase_auth.dart';
import 'package:firenoteapp/sign_in_page.dart';
import 'package:firenoteapp/sign_up_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthService {
  static String? snackBar;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signUpUser(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print("response: ${userCredential.toString()}");
      User? user = userCredential.user;
      if (kDebugMode) {
        print(user.toString());
      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snackBar = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        snackBar = 'The account already exists for that email.';
      } else {
        print("error: ${e.toString()}");
      }
      print("snackBar: $snackBar");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      snackBar = e.toString();
    }
    return null;
  }

  static Future<User?> signInUser(String email, String password) async {
    print('test4');
    try {
      print('test6');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('test5');
      User? user = userCredential.user;
      print(user.toString());
      return user;
    } on FirebaseAuthException catch (e) {
      print('test5');

      if (e.code == 'user-not-found') {
        snackBar = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        snackBar = 'Wrong password provided for that user.';
      }
    }

    return null;
  }

  static Future<void> signOutUser(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  static Future<void> removeUser(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
      Navigator.pushReplacementNamed(context, SignUpPage.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        snackBar =
            'The user must authenticate before this operation can be executed.';
      }
    }
  }
}
