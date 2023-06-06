import 'package:tcean/models/address.dart';

class Account {
  final String uid;
  final String? name;
  final String phoneNumber;
  final String? email;
  final int balance;
  final List<Address>? addresses;
  final List<CourierBruch>? courierAddresses;

  Account({
    required this.uid,
    this.name,
    required this.phoneNumber,
    this.email,
    this.balance = 0,
    this.addresses,
    this.courierAddresses,
  });
}

Account dummyAccount = Account(
    uid: "uid",
    name: "name",
    phoneNumber: "phoneNumber",
    email: "srksifat.dev@gmail.com",
    balance: 300,
    addresses: [
      Address(
          addressName: "addressName",
          district: "district",
          area: "area",
          detailsAddress: "detailsAddress"),
    ]);
