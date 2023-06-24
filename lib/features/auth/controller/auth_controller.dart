import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginInfo extends ChangeNotifier {
  var _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}

GoogleSignInAccount? gUser;
final loginInfo = LoginInfo();

class AuthController {
  static String? userName;
  static String? userPhotoUrl;
  static String? userEmail;

  static Future<void> signInWithGoogle() async {
    try {
      gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      if (gAuth.accessToken != null && gAuth.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        LoginInfo().isLoggedIn = true;
        if (userCredential.additionalUserInfo!.isNewUser) {
          //TODO: Save Account Information in Firebase Firestore
        }
      } else {
        print("Nothing");
      }
      userName = gUser!.displayName;
      userPhotoUrl = gUser!.photoUrl;
      userEmail = gUser!.email;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } on PlatformException catch (error) {
      if (error.code == 'sign_in_canceled') {
        Fluttertoast.showToast(msg: "Select any Google account to sign in");
      } else {
        print('Error signing in: $error');
      }
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
