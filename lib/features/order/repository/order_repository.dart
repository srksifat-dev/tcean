import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tcean/core/constants/firebase_constants.dart';
import 'package:tcean/core/failure.dart';
import 'package:tcean/core/providers/firebase_providers.dart';
import 'package:tcean/core/type_defs.dart';
import 'package:tcean/models/address_model.dart';
import 'package:tcean/models/order_model.dart';

import '../../../models/cart_model.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(firestore: ref.read(firestoreProvider));
});

class OrderRepository {
  final FirebaseFirestore _firestore;

  OrderRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _orders =>
      _firestore.collection(FirebaseConstants.ordersCollection);

  Future<void> addOrder({
    required OrderModel orderModel,
    required List<CartModel> carts,
    required AddressModel addressModel,
  }) async {
    try {
      _orders.doc(orderModel.orderID).set(orderModel.toMap());
      for (CartModel cart in carts) {
        Map<String, dynamic> toMap() {
          return <String, dynamic>{
            "cartID": cart.cartID,
            "productID": cart.productID,
            "quantity": cart.quantity,
            "totalExpense": cart.totalExpense,
            "color": cart.color,
            "size": cart.size,
          };
        }

        _orders
            .doc(orderModel.orderID)
            .collection(FirebaseConstants.cartsCollection)
            .doc()
            .set(toMap());

        _orders
            .doc(orderModel.orderID)
            .collection(FirebaseConstants.addressCollection)
            .doc()
            .set(addressModel.toMap());
      }
    } on FirebaseException catch (e) {
      Failure(e.message!);
    } catch (e) {
      Failure(e.toString());
    }
  }

  Stream<List<OrderModel>> getOrders({required String uid}) {
    return _orders.where("billerID", isEqualTo: uid).snapshots().map((event) =>
        event.docs
            .map((e) => OrderModel.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<CartModel>> getCartsOfOrders({required String orderID}) {
    return _orders
        .doc(orderID)
        .collection(FirebaseConstants.cartsCollection)
        .snapshots()
        .map((event) => event.docs
            .map((e) => CartModel(cartID: e["id"],color: e["cartID"],productID: e["productID"],quantity: e["quantity"],size: e["size"],totalExpense: e["totalExpense"],),
              )
            .toList());
  }

  Stream<AddressModel> getReceiverAddress({required String orderID}) {
    return _orders
        .doc(orderID)
        .collection(FirebaseConstants.addressCollection)
        .snapshots()
        .map((event) => AddressModel.fromMap(event as Map<String, dynamic>));
  }
}
