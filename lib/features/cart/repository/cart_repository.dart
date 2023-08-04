import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:tcean/core/providers/isar_provider.dart';
import 'package:tcean/models/cart_model.dart';

// final cartRepositoryProvider = FutureProvider<CartRepository>((ref) {
//   return CartRepository(db: ref.read(isarProvider.future));
// });

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository(db: ref.watch(isarProvider.future));
});

class CartRepository {
  final Future<Isar> _db;
  CartRepository({required Future<Isar> db}) : _db = db;

// Create Cart
  Future<void> addCart({required CartModel cartModel}) async {
    final isar = await _db;

    return isar.writeTxnSync(() => isar.cartModels.putSync(cartModel));
  }

  // Read Cart

  Stream<List<CartModel>> getCarts() async* {
    final isar = await _db;

    yield* isar.cartModels.where().watch(fireImmediately: true);
  }

  Future<List<CartModel>> getCartsFuture() async {
    final isar = await _db;
    return isar.cartModels.where().findAll();
  }

  // Update Cart
  Future<void> editCart({required Id cartID, required CartModel cart}) async {
    final isar = await _db;
    CartModel? cartModel = await isar.cartModels.get(cartID);
    if (cartModel != null) {
      cartModel = cart;
    }
    return isar.writeTxn(() => isar.cartModels.put(cartModel!));
  }

  Future<void> addQuantity({
    required Id cartID,
    required int productPrice,
  }) async {
    final isar = await _db;
    CartModel? cartModel = await isar.cartModels.get(cartID);
    cartModel!.quantity++;
    cartModel.totalExpense = cartModel.quantity * productPrice;
    isar.writeTxn(() => isar.cartModels.put(cartModel));
  }

  Future<void> removeQuantity({
    required Id cartID,
    required int productPrice,
  }) async {
    final isar = await _db;
    CartModel? cartModel = await isar.cartModels.get(cartID);
    if (cartModel!.quantity > 1) {
      cartModel.quantity--;
    }
    cartModel.totalExpense = cartModel.quantity * productPrice;
    isar.writeTxn(() => isar.cartModels.put(cartModel));
  }

  // Delete Cart

  Future<void> deleteCart({required Id cartID}) async {
    final isar = await _db;
    await isar.writeTxn(() => isar.cartModels.delete(cartID));
  }

  Future<void> deleteAllCart() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.cartModels.clear());
  }
}
