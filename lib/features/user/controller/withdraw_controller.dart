import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/features/user/repository/withdraw_repository.dart';
import 'package:tcean/models/withdraw_request_model.dart';

import '../../../core/utils.dart';

final withdrawControllerProvider = Provider<WithdrawController>((ref) {
  return WithdrawController(
      withdrawRepository: ref.watch(withdrawRepositoryProvider), ref: ref);
});

final getWithdrawRequestProvider =
    StreamProvider.family<WithdrawRequestModel, String>(
        (ref, withdrawID) {
  final withdrawController = ref.watch(withdrawControllerProvider);
  return withdrawController.getWithdrawRequest(withdrawID: withdrawID);
});

class WithdrawController {
  final WithdrawRepository _withdrawRepository;
  final Ref _ref;

  WithdrawController(
      {required WithdrawRepository withdrawRepository, required Ref ref})
      : _withdrawRepository = withdrawRepository,
        _ref = ref;

  // Create withdraw
  void requestForWithdraw({
    required BuildContext context,
    required String withdrawID,
    required String date,
    required String uid,
    required int amount,
    required String paymentMethod,
    required String gatewayNumber,
    required String withdrawStatus,
  }) async {
    WithdrawRequestModel withdraw = WithdrawRequestModel(
      withdrawRequestID: withdrawID,
      date: date,
      uid: uid,
      amount: amount,
      paymentMethod: paymentMethod,
      gatewayNumber: gatewayNumber,
      withdrawStatus: withdrawStatus,
    );

    final res =
        await _withdrawRepository.requestForWithdraw(withdraw: withdraw);
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, "Withdraw has requested successfully!");
      context.pop();
    });
  }

  Stream<WithdrawRequestModel> getWithdrawRequest(
      {required String withdrawID}) {
    return _withdrawRepository.getWithdrawRequestModel(withdrawID: withdrawID);
  }
}
