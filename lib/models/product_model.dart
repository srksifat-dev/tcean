import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';

List<ProductModel> products = [];

class ProductModel {
  final String productID;
  final String productName;
  final Delta description;
  final int price;
  final List<String> productImageUrls;
  final List<String> categories;
  final String productCreated;
  final int sellNumber;
  final String productLabel;
  bool visibility;
  final int viewTimes;
  ProductModel({
    required this.productID,
    required this.productName,
    required this.description,
    required this.price,
    required this.productImageUrls,
    required this.categories,
    required this.productCreated,
    required this.sellNumber,
    required this.productLabel,
    required this.visibility,
    required this.viewTimes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'productName': productName,
      'description': jsonEncode(description.toJson()),
      'price': price,
      'productImageUrls': productImageUrls,
      'categories': categories,
      'productCreated': productCreated,
      'sellNumber': sellNumber,
      'productLabel': productLabel,
      "visibility": visibility,
      "viewTimes": viewTimes,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productID: map["productID"],
      productName: map["productName"],
      description: Delta.fromJson(jsonDecode(map["description"])),
      price: map["price"],
      productImageUrls: (map["productImageUrls"] as List).cast<String>(),
      categories: (map["categories"] as List).cast<String>(),
      productCreated: map["productCreated"],
      sellNumber: map["sellNumber"],
      productLabel: map["productLabel"],
      visibility: map["visibility"],
      viewTimes: map["viewTimes"],
    );
  }
}
