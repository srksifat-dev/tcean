import 'package:flutter/foundation.dart';

import 'package:tcean/models/address.dart';

import '../dummy/dummy_chats.dart';
import 'chat.dart';

class UserModel {
  final String uid;
  final String? name;
  final String? profilePic;
  final String phoneNumber;
  final String? email;
  final int balance;
  final List<Address>? addresses;
  final List<CourierBruch>? courierAddresses;
  final List<Chat>? chats;
  final String? liveActivity;
  final bool isActive;
  UserModel({
    required this.uid,
    this.name,
    this.profilePic,
    required this.phoneNumber,
    this.email,
    required this.balance,
    this.addresses,
    this.courierAddresses,
    this.chats,
    this.liveActivity,
    required this.isActive,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? profilePic,
    String? phoneNumber,
    String? email,
    int? balance,
    List<Address>? addresses,
    List<CourierBruch>? courierAddresses,
    List<Chat>? chats,
    String? liveActivity,
    bool? isActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      addresses: addresses ?? this.addresses,
      courierAddresses: courierAddresses ?? this.courierAddresses,
      chats: chats ?? this.chats,
      liveActivity: liveActivity ?? this.liveActivity,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
      'email': email,
      'balance': balance,
      'addresses': addresses,
      'courierAddresses': courierAddresses,
      'chats': chats,
      'liveActivity': liveActivity,
      'isActive': isActive,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      balance: map['balance'] as int,
      addresses: map['addresses'] ?? [],
      courierAddresses: map['courierAddresses'] ?? [],
      chats: map['chats'] ?? [],
      liveActivity:
          map['liveActivity'] != null ? map['liveActivity'] as String : null,
      isActive: map['isActive'] as bool,
    );
  }
}

UserModel dummyAccount = UserModel(
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
  ],
  liveActivity: "Explore screen",
  isActive: true,
  chats: dummyChats,
);
