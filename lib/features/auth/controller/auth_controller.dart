import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcean/features/auth/repository/auth_repository.dart';

import '../../../core/utils.dart';
import '../../../models/user.dart';

// GoogleSignInAccount? gUser;

// class AuthController {
//   static String? userName;
//   static String? userPhotoUrl;
//   static String? userEmail;

//   static Future<void> signInWithGoogle() async {
//     try {
//       gUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication gAuth = await gUser!.authentication;
//       if (gAuth.accessToken != null && gAuth.idToken != null) {
//         final credential = GoogleAuthProvider.credential(
//           accessToken: gAuth.accessToken,
//           idToken: gAuth.idToken,
//         );
//         UserCredential userCredential =
//             await FirebaseAuth.instance.signInWithCredential(credential);
//         if (userCredential.additionalUserInfo!.isNewUser) {
//           //TODO: Save Account Information in Firebase Firestore
//         }
//       } else {
//         print("Nothing");
//       }
//       userName = gUser!.displayName;
//       userPhotoUrl = gUser!.photoUrl;
//       userEmail = gUser!.email;
//     } on FirebaseAuthException catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     } on PlatformException catch (error) {
//       if (error.code == 'sign_in_canceled') {
//         Fluttertoast.showToast(msg: "Select any Google account to sign in");
//       } else {
//         print('Error signing in: $error');
//       }
//     }
//   }

//   static Future<void> signOut() async {
//     await FirebaseAuth.instance.signOut();
//   }
// }

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider), ref: ref));
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);

  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);

  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);
  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold((l) => showSnackBar(context, l.message),
        (r) => _ref.read(userProvider.notifier).update((state) => r));
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
