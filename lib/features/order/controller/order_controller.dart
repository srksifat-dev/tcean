import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/features/order/repository/order_repository.dart';
import 'package:tcean/main.dart';
import 'package:tcean/models/address_model.dart';
import 'package:tcean/models/cart_model.dart';
import 'package:tcean/models/order_model.dart';

final orderExpenseProvider = StateProvider<int>((ref) {
  return 0;
});

final deliveryChargeProvider = StateProvider<int>((ref) {
  return 0;
});

final quantityProvider = StateProvider<int>((ref) {
  return 0;
});

final getOrdersProvider =
    StreamProvider.family<List<OrderModel>, String>((ref, uid) {
  final orderController = ref.read(orderControllerProvider);
  return orderController.getOrders(uid: uid);
});

final getCartsOfOrderProvider =
    StreamProvider.family<List<CartModel>, String>((ref, orderID) {
  final orderController = ref.read(orderControllerProvider);
  return orderController.getCartsOfOrder(orderID: orderID);
});

final getReceiverAddressProvider =
    StreamProvider.family<AddressModel, String>((ref, orderID) {
  final orderController = ref.read(orderControllerProvider);
  return orderController.getReceiverAddress(orderID: orderID);
});

final orderControllerProvider = Provider<OrderController>((ref) {
  return OrderController(
      orderRepository: ref.read(orderRepositoryProvider), ref: ref);
});

class OrderController {
  final OrderRepository _orderRepository;
  final Ref _ref;

  OrderController({required OrderRepository orderRepository, required Ref ref})
      : _orderRepository = orderRepository,
        _ref = ref;

  void addOrder({
    required int orderExpense,
    required int deliveryCharge,
    String? couponName,
    required bool paymentStatus,
    required String deliveryMethod,
    required String orderStatus,
    required String orderTime,
    required String billerUID,
    required String receiverName,
    required String receiverContactNumber,
    required String receiverEmail,
    required List<CartModel> carts,
    // required Id cartID,
    // required String productID,
    // required int quantity,
    // required int totalExpense,
    // required String color,
    // required String size,
    required String district,
    required String area,
    required String detailsAddress,
  }) {
    OrderModel orderModel = OrderModel(
      orderID: DateTime.now().toString().trim(),
      orderExpense: orderExpense,
      deliveryCharge: deliveryCharge,
      couponName: couponName,
      paymentStatus: paymentStatus,
      deliveryMethod: deliveryMethod,
      orderStatus: orderStatus,
      orderTime: DateTime.now().toString().trim(),
      billerUID: userModel!.uid,
      receiverName: receiverName,
      receiverContactNumber: receiverContactNumber,
      receiverEmail: receiverEmail,
    );

    AddressModel addressModel = AddressModel(
      district: district,
      area: area,
      detailsAddress: detailsAddress,
    );

    _orderRepository.addOrder(
      orderModel: orderModel,
      carts: carts,
      addressModel: addressModel,
    );
  }

  Stream<List<OrderModel>> getOrders({required String uid}) {
    return _orderRepository.getOrders(uid: uid);
  }

  Stream<List<CartModel>> getCartsOfOrder({required String orderID}) {
    return _orderRepository.getCartsOfOrders(orderID: orderID);
  }

  Stream<AddressModel> getReceiverAddress({required String orderID}) {
    return _orderRepository.getReceiverAddress(orderID: orderID);
  }
}
