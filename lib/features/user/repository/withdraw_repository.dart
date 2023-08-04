import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tcean/core/constants/firebase_constants.dart';
import 'package:tcean/core/failure.dart';
import 'package:tcean/core/providers/firebase_providers.dart';
import 'package:tcean/core/type_defs.dart';
import 'package:tcean/models/withdraw_request_model.dart';

final withdrawRepositoryProvider = Provider<WithdrawRepository>((ref) {
  return WithdrawRepository(firestore: ref.read(firestoreProvider));
});

class WithdrawRepository {
  final FirebaseFirestore _firestore;
  WithdrawRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _withdraws =>
      _firestore.collection(FirebaseConstants.withdrawCollection);

// Create withdraw
  FutureVoid requestForWithdraw(
      {required WithdrawRequestModel withdraw}) async {
    try {
      return right(
          _withdraws.doc(withdraw.withdrawRequestID).set(withdraw.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<WithdrawRequestModel> getWithdrawRequestModel(
      {required String withdrawID}) {
    return _withdraws.doc(withdrawID).snapshots().map((event) =>
        WithdrawRequestModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
