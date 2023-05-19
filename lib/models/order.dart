import 'package:tcean/models/address.dart';
import 'package:tcean/models/cart.dart';
import 'package:tcean/models/coupon.dart';

enum OrderStep {
  confirmed,
  processing,
  packed,
  shipped,
  delivered,
}

enum DeliveryMethod {
  cod,
  scs,
}

class Order {
  final String orderID;
  final List<Cart> carts;
  final int orderExpense;
  final int deliveryCharge;
  final Coupon? coupon;
  final bool paymentStatus;
  final DeliveryMethod deliveryMethod;
  final Address? address;
  final CourierAddress? courierAddress;
  final OrderStep orderStep;
  final String orderTime;

  Order({
    required this.orderID,
    required this.carts,
    required this.orderExpense,
    required this.deliveryCharge,
    this.coupon,
    required this.paymentStatus,
    required this.deliveryMethod,
    this.address,
    this.courierAddress,
    required this.orderStep,
    required this.orderTime,
  });
}
