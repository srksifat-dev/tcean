import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tcean/core/constants/firebase_constants.dart';
import 'package:tcean/core/failure.dart';
import 'package:tcean/core/providers/firebase_providers.dart';
import 'package:tcean/core/type_defs.dart';
import 'package:tcean/core/utils.dart';
import 'package:tcean/main.dart';
import 'package:tcean/models/cart_model.dart';

import '../../../core/providers/isar_provider.dart';

// final cartRepositoryProvider = Provider<CartRepository>((ref) {
//   return CartRepository(db: ref.read(isarProvider.future));
// });

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository(firestore: ref.read(firestoreProvider));
});

class CartRepository {
  final FirebaseFirestore _firestore;
  CartRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _carts =>
      _firestore.collection(FirebaseConstants.cartsCollection);

  // Create
  FutureVoid addToCart({required CartModel cartModel}) async {
    try {
      return right(_carts
          .doc(cartModel.cartID)
          .set(cartModel.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Read
  Stream<List<CartModel>> getCarts() {
    return _carts.snapshots().map(
        (event) => event.docs.map((e) => CartModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }

  // Update
  FutureVoid addQuantity({
    required String cartID,
    required int productPrice,
    required int quantity,
  }) async {
    try {
      return right(_carts
          .doc(cartID)
          .update({
        "quantity": (quantity + 1),
        "totalExpense": (quantity +1) * productPrice
      }));
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> removeQuantity({
    required String cartID,
    required int productPrice,
    required int quantity,
  }) async {
    if (quantity > 1) {
      _carts.doc(cartID).update(
        {"quantity": (quantity - 1), "totalExpense": (quantity - 1) * productPrice},
      );
    }
  }

  // delete
  Future<void> deleteCart({required String cartID}) async {
    _carts.doc(cartID).delete();
  }

  Future<void> deleteAllCart() async {
    _carts.doc().delete();
  }
}

// class CartRepository {
//   final Future<Isar> _db;
//   CartRepository({required Future<Isar> db}) : _db = db;
// // Create Cart
//   Future<void> addCart({required CartModel cartModel}) async {
//     var isar = await _db;
//       return isar.writeTxnSync(() => isar.cartModels.putSync(cartModel));
    
//   }

//   // Read Cart

//   Stream<List<CartModel>> getCarts() async* {
//     final isar = await _db;

//     yield* isar.cartModels.where().watch(fireImmediately: true);
//   }

//   Future<List<CartModel>> getCartsFuture() async {
//     final isar = await _db;
//     return isar.cartModels.where().findAll();
//   }

//   // Update Cart
//   Future<void> editCart({required Id cartID, required CartModel cart}) async {
//     final isar = await _db;
//     CartModel? cartModel = await isar.cartModels.get(cartID);
//     if (cartModel != null) {
//       cartModel = cart;
//     }
//     return isar.writeTxn(() => isar.cartModels.put(cartModel!));
//   }

//   Future<void> addQuantity({
//     required Id cartID,
//     required int productPrice,
//   }) async {
//     final isar = await _db;
//     CartModel? cartModel = await isar.cartModels.get(cartID);
//     cartModel!.quantity++;
//     cartModel.totalExpense = cartModel.quantity * productPrice;
//     isar.writeTxn(() => isar.cartModels.put(cartModel));
//   }

//   Future<void> removeQuantity({
//     required Id cartID,
//     required int productPrice,
//   }) async {
//     final isar = await _db;
//     CartModel? cartModel = await isar.cartModels.get(cartID);
//     if (cartModel!.quantity > 1) {
//       cartModel.quantity--;
//     }
//     cartModel.totalExpense = cartModel.quantity * productPrice;
//     isar.writeTxn(() => isar.cartModels.put(cartModel));
//   }

//   // Delete Cart

//   Future<void> deleteCart({required Id cartID}) async {
//     final isar = await _db;
//     await isar.writeTxn(() => isar.cartModels.delete(cartID));
//   }

//   Future<void> deleteAllCart() async {
//     final isar = await _db;
//     await isar.writeTxn(() => isar.cartModels.clear());
//   }
// }
