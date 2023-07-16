import 'package:tcean/models/product_model.dart';

class Cart {
  final ProductModel product;
  final int quantity;
  final int totalExpense;
  final String color;
  final String size;

  Cart({
    required this.size,
    required this.color,
    required this.product,
    required this.quantity,
    required this.totalExpense,
  });
}
