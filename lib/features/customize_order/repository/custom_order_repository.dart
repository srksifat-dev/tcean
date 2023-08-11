import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tcean/core/constants/firebase_constants.dart';
import 'package:tcean/core/failure.dart';
import 'package:tcean/core/type_defs.dart';
import 'package:tcean/models/custom_order_model.dart';
import 'package:tcean/models/design_model.dart';

class CustomOrderRepository {
  final FirebaseFirestore _firestore;
  CustomOrderRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _customOrders =>
      _firestore.collection(FirebaseConstants.customOrdersCollection);

  // Add Custom Orders

  FutureVoid addCustomOrder(
      {required CustomOrderModel customOrderModel}) async {
    try {
      return right(_customOrders
          .doc(customOrderModel.orderID)
          .set(customOrderModel.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid addDesign(
      {required String orderID, required DesignModel designModel}) async {
    try {
      return right(_customOrders
          .doc(orderID)
          .collection("designs")
          .doc()
          .set(designModel.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Read
}
