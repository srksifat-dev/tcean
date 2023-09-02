import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:tcean/features/cart/repository/cart_repository.dart';
import 'package:tcean/models/cart_model.dart';

final addCartProvider =
    FutureProvider.family<Future<void>, CartModel>((ref, cart) {
  final cartController = ref.watch(cartRepositoryProvider);
  return cartController.addToCart(cartModel: cart);
});

final getCartsProvider = StreamProvider<List<CartModel>?>((ref) {
  final cartController = ref.watch(cartControllerProvider);
  return cartController.getCarts();
});

final cartControllerProvider = Provider<CartController>((ref) {
  return CartController(
      cartRepository: ref.read(cartRepositoryProvider), ref: ref);
});

final deleteCartProvider = Provider.family<Future<void>,String>((ref, cartID) {
  final cartController = ref.watch(cartControllerProvider);
  return cartController.deleteCart(cartID: cartID);
});

final deleteAllCartProvider = FutureProvider<void>((ref) {
  final cartController = ref.watch(cartControllerProvider);
  return cartController.deleteAllCart();
});

class CartController {
  final CartRepository _cartRepository;
  final Ref _ref;

  CartController({required CartRepository cartRepository, required Ref ref})
      : _cartRepository = cartRepository,
        _ref = ref;

  // Create Cart
  Future<void> addToCart({required CartModel cart})async {
    _cartRepository.addToCart(cartModel: cart);
  }

  // Read Cart
  Stream<List<CartModel>> getCarts() {
    return _cartRepository.getCarts();
  }

  // Future<List<CartModel>> getCartsFuture() {
  //   return _cartRepository.getCartsFuture();
  // }

  // Update Cart

  // Future<void> editCart({required Id cartID, required CartModel cartModel}) {
  //   return _cartRepository.editCart(cartID: cartID, cart: cartModel);
  // }
  Future<void> addQuantity({
    required String cartID,
    required int quantity,
    required int productPrice,
  })async {
    _cartRepository.addQuantity(
        cartID: cartID, productPrice: productPrice, quantity: quantity);
  }

  // Future<void> addQuantity({
  //   required Id cartID,
  //   required int productPrice,
  // }) {
  //   return _cartRepository.addQuantity(
  //     cartID: cartID,
  //     productPrice: productPrice,
  //   );
  // }
  Future<void> removeQuantity(
      {required String cartID,
      required int quantity,
      required int productPrice}) async{
    _cartRepository.removeQuantity(
        cartID: cartID, productPrice: productPrice, quantity: quantity);
  }
  // Future<void> removeQuantity({required Id cartID, required int productPrice}) {
  //   return _cartRepository.removeQuantity(
  //       cartID: cartID, productPrice: productPrice);
  // }

  // Delete Cart
  Future<void> deleteCart({required String cartID}) async{
    _cartRepository.deleteCart(cartID: cartID);
  }
  // Future<void> deleteCart({required Id cartID}) {
  //   return _cartRepository.deleteCart(cartID: cartID);
  // }

  Future<void> deleteAllCart() async {
    return await _cartRepository.deleteAllCart();
  }
}
