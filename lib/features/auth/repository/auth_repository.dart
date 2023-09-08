import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcean/core/constants/firebase_constants.dart';
import 'package:tcean/core/failure.dart';
import 'package:tcean/core/providers/firebase_providers.dart';
import 'package:tcean/models/address_model.dart';
import 'package:tcean/models/user_model.dart';

import '../../../core/type_defs.dart';
import '../../../main.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        googleAuthProvider
            .addScope("https://www.googleapis.com/auth/contacts.readonly");
        userCredential = await _auth.signInWithPopup(googleAuthProvider);
      }else{
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final credential = GoogleAuthProvider.credential(
          accessToken: (await googleUser?.authentication)?.accessToken,
          idToken: (await googleUser?.authentication)?.idToken);
          userCredential = await _auth.signInWithCredential(credential);
          }
      
      
      // UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          uid: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? "A tcean Lover",
          email: userCredential.user!.email,
          phoneNumber: userCredential.user!.phoneNumber ?? "01xxxxxxxxx",
          balance: 0,
          isActive: true,
        );
        await _users.doc(userCredential.user!.uid).set(userModel!.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel!);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid addAddress(
      {required String uid, required AddressModel addressModel}) async {
    try {
      return right(
        _users.doc(uid).collection("addresses").doc().set(addressModel.toMap()),
      );
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<AddressModel>> getAddresses({required String uid}) {
    return _users.doc(uid).collection("addresses").snapshots().map((event) =>
        event.docs.map((e) => AddressModel.fromMap(e.data())).toList());
  }

  FutureVoid setAsDefaultAddress({
    required String uid,
    required int defaultIndex,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _users
          .doc(uid)
          .collection(FirebaseConstants.addressCollection)
          .get();
      var v = querySnapshot.docs.forEach((documentSnapshot) async {
        await documentSnapshot.reference.update({"defaultIndex": defaultIndex});
      });
      return right(v);
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // FutureVoid editUserName({
  //   required String uid,
  //   required String userName,
  // }) async {
  //   try {
  //     return right(_users.doc(uid).update({"name":userName}));
  //   } on FirebaseAuthException catch (e) {
  //     return left(Failure(e.toString()));
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  FutureVoid editUserPhoneNumber({
    required String uid,
    required String phoneNumber,
  }) async {
    try {
      return right(_users.doc(uid).update({"phoneNumber": phoneNumber}));
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
