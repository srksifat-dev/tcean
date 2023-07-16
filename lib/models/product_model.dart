
import 'package:flutter_quill/flutter_quill.dart';

class ProductModel {
  final String productID;
  final String productName;
  final Document? description;
  final int price;
  final int costingPrice;
  final List<String> productImageUrls;
  final List<String> categories;
  final String productCreated;
  final int sellNumber;
  final String productLabel;
  ProductModel({
    required this.productID,
    required this.productName,
    this.description,
    required this.price,
    required this.costingPrice,
    required this.productImageUrls,
    required this.categories,
    required this.productCreated,
    required this.sellNumber,
    required this.productLabel,
  });

  ProductModel copyWith({
    String? productID,
    String? productName,
    Document? description,
    int? price,
    int? costingPrice,
    List<String>? productImageUrls,
    List<String>? categories,
    String? productCreated,
    int? sellNumber,
    String? productLabel,
  }) {
    return ProductModel(
      productID: productID ?? this.productID,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      price: price ?? this.price,
      costingPrice: costingPrice ?? this.costingPrice,
      productImageUrls: productImageUrls ?? this.productImageUrls,
      categories: categories ?? this.categories,
      productCreated: productCreated ?? this.productCreated,
      sellNumber: sellNumber ?? this.sellNumber,
      productLabel: productLabel ?? this.productLabel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'productName': productName,
      'description': description,
      'price': price,
      'costingPrice': costingPrice,
      'productImageUrls': productImageUrls,
      'categories': categories,
      'productCreated': productCreated,
      'sellNumber': sellNumber,
      'productLabel': productLabel,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productID: map['productID'] as String,
      productName: map['productName'] as String,
      description: map['description'],
      price: map['price'] as int,
      costingPrice: map['costingPrice'] as int,
      productImageUrls: List<String>.from((map['productImageUrls'] as List<String>)),
      categories: map['categories'],
      productCreated: map['productCreated'] as String,
      sellNumber: map['sellNumber'] as int,
      productLabel: map['productLabel'] as String,
    );
  }
}
