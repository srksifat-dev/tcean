import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/core/providers/storage_repository_provider.dart';
import 'package:tcean/features/customize_order/repository/custom_order_repository.dart';
import 'package:tcean/models/custom_order_model.dart';

import '../../../core/utils.dart';

class CustomOrderController extends StateNotifier<bool> {
  final CustomOrderRepository _customOrderRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  CustomOrderController(
      {required CustomOrderRepository customOrderRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _customOrderRepository = customOrderRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  // Add Custom Order

  void addCustomOrder({
    required BuildContext context,
    required String orderID,
    List<Uint8List>? designs,
    required String color,
    required String size,
    required int quantity,
    required int totalExpense,
    required int deliveryCharge,
    String? couponName,
    required bool paymentStatus,
    required String deliveryMethod,
    required String orderStatus,
    required String orderTime,
    required String billerID,
    required String receiverName,
    required String receiverContactNumber,
    required String receiverEmail,
  }) async {
    state = true;
    final res = await _storageRepository.storeCustomOrderFiles(
        customOrderID: orderID, files: designs!);

    res.fold((l) => showSnackBar(context, l.message), (r) async {
      CustomOrderModel(
          orderID: orderID,
          color: color,
          size: size,
          quantity: quantity,
          totalExpense: totalExpense,
          deliveryCharge: deliveryCharge,
          paymentStatus: paymentStatus,
          deliveryMethod: deliveryMethod,
          orderStatus: orderStatus,
          orderTime: orderTime,
          billerID: billerID,
          receiverName: receiverName,
          receiverContactNumber: receiverContactNumber,
          receiverEmail: receiverEmail);
    });
  }
}
