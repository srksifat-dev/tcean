import 'package:tcean/models/address.dart';

import '../dummy/dummy_chats.dart';
import 'chat.dart';

class Account {
  final String uid;
  final String? name;
  final String phoneNumber;
  final String? email;
  final int balance;
  final List<Address>? addresses;
  final List<CourierBruch>? courierAddresses;
  final List<Chat>? chats;
  final String? liveActivity;
  final bool isActive;

  Account({
    required this.uid,
    this.name,
    required this.phoneNumber,
    this.email,
    this.balance = 0,
    this.addresses,
    this.courierAddresses,
    this.chats,
    this.liveActivity,
    required this.isActive,
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
          
    ],liveActivity: "Explore screen",
    isActive: true,
    chats: dummyChats,);
