import 'address.dart';
import 'cart.dart';
import 'coupon.dart';

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
  final CourierBruch? courierBrunch;
  final OrderStep orderStep;
  final DateTime orderTime;
  final String receiverName;
  final String receiverContactNumber;
  final String? receiverEmail;

  Order({
    required this.orderID,
    required this.carts,
    required this.orderExpense,
    required this.deliveryCharge,
    this.coupon,
    required this.paymentStatus,
    required this.deliveryMethod,
    this.address,
    this.courierBrunch,
    required this.orderStep,
    required this.orderTime,
    required this.receiverContactNumber,
    this.receiverEmail,
    required this.receiverName,
  });
}
