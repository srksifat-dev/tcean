import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/features/auth/repository/auth_repository.dart';

import '../../../core/utils.dart';
import '../../../models/address_model.dart';
import '../../../models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final getAddressesProvider =
    StreamProvider.family<List<AddressModel>, String>((ref, uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getAddresses(uid: uid);
});

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider), ref: ref));

final authStateChangeProvider = StreamProvider<User?>((ref) {
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

  // void editUserName({required String uid, required String userName,}) async {
  //   _authRepository.editUserName(uid: uid, userName: userName);
  // }
  void addAddress({required String uid, required AddressModel address}) async {
    _authRepository.addAddress(uid: uid, addressModel: address);
  }

  Stream<List<AddressModel>> getAddresses({required String uid}) {
    return _authRepository.getAddresses(uid: uid);
  }

  void editUserPhoneNumber({
    required String uid,
    required String userPhoneNumber,
  }) async {
    _authRepository.editUserPhoneNumber(
      uid: uid,
      phoneNumber: userPhoneNumber,
    );
  }

  void setAsDefaultAddress({required String uid, required int defaultIndex}) {
    _authRepository.setAsDefaultAddress(uid: uid, defaultIndex: defaultIndex);
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void logout() async {
    _authRepository.logOut();
  }
}
