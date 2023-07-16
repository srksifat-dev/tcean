import 'package:tcean/dummy/dummy_product.dart';
import 'package:tcean/models/user.dart';
import 'package:tcean/models/address.dart';

import '../models/order.dart';

List<Order> dummyOrders = [
  Order(
    orderID: "orderID",
    carts: Dummy.carts,
    paymentStatus: true,
    deliveryMethod: DeliveryMethod.cod,
    address: Address(
        addressName: "addressName",
        district: "district",
        area: "area",
        detailsAddress: "detailsAddress"),
    orderStep: OrderStep.confirmed,
    orderTime: DateTime.now().toString(),
    orderExpense: 300,
    deliveryCharge: 60,
    receiverContactNumber: dummyAccount.phoneNumber,
    receiverEmail: dummyAccount.email,
    receiverName: dummyAccount.name!,
  ),
  Order(
    orderID: "orderID",
    carts: Dummy.carts,
    paymentStatus: true,
    deliveryMethod: DeliveryMethod.scs,
    address: Address(
        addressName: "addressName",
        district: "district",
        area: "area",
        detailsAddress: "detailsAddress"),
    orderStep: OrderStep.processing,
    orderTime: DateTime.now().toString(),
    orderExpense: 300,
    deliveryCharge: 60,
    receiverContactNumber: dummyAccount.phoneNumber,
    receiverEmail: dummyAccount.email,
    receiverName: dummyAccount.name!,
  ),
];
