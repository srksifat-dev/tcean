import '../models/user.dart';
import '../models/address.dart';
import '../models/order_model.dart';
import 'dummy_cart.dart';

List<Order> dummyOrders = [
  Order(
    orderID: "orderID",
    carts: carts,
    paymentStatus: true,
    deliveryMethod: DeliveryMethod.cod,
    address: Address(
        addressName: "addressName",
        district: "district",
        area: "area",
        detailsAddress: "detailsAddress"),
    orderStep: OrderStep.confirmed,
    orderTime: DateTime.now(),
    orderExpense: 300,
    deliveryCharge: 60,
    receiverContactNumber: "dummyAccount[0].phoneNumber",
    receiverEmail: "dummyAccount[0].email",
    receiverName: "dummyAccount[0].name!",
  ),
  Order(
    orderID: "orderID",
    carts: carts,
    paymentStatus: true,
    deliveryMethod: DeliveryMethod.scs,
    address: Address(
        addressName: "addressName",
        district: "district",
        area: "area",
        detailsAddress: "detailsAddress"),
    orderStep: OrderStep.processing,
    orderTime: DateTime.now(),
    orderExpense: 300,
    deliveryCharge: 60,
    receiverContactNumber: "dummyAccount[0].phoneNumber",
    receiverEmail: "dummyAccount[0].email",
    receiverName: "dummyAccount[0].name!",
  ),
];
