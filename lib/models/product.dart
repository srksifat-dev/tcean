import 'package:flutter_quill/flutter_quill.dart';

class Product {
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

  Product({
    required this.productCreated,
    required this.productID,
    required this.productName,
    this.description,
    required this.price,
    required this.costingPrice,
    required this.productImageUrls,
    required this.categories,
    required this.sellNumber,
    required this.productLabel,
  });
}

