

class CartModel {
  final String cartID;
  final String productID;
  int quantity;
  int totalExpense;
  String color;
  String size;
  CartModel({
    required this.cartID,
    required this.productID,
    required this.quantity,
    required this.totalExpense,
    required this.color,
    required this.size,
  });

  CartModel copyWith({
    String? cartID,
    String? productID,
    int? quantity,
    int? totalExpense,
    String? color,
    String? size,
  }) {
    return CartModel(
      cartID: cartID ?? this.cartID,
      productID: productID ?? this.productID,
      quantity: quantity ?? this.quantity,
      totalExpense: totalExpense ?? this.totalExpense,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartID': cartID,
      'productID': productID,
      'quantity': quantity,
      'totalExpense': totalExpense,
      'color': color,
      'size': size,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartID: map['cartID'] as String,
      productID: map['productID'] as String,
      quantity: map['quantity'] as int,
      totalExpense: map['totalExpense'] as int,
      color: map['color'] as String,
      size: map['size'] as String,
    );
  }
}
