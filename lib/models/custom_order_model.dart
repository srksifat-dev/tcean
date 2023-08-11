
class CustomOrderModel {
  final String orderID;
  final String color;
  final String size;
  final int quantity;
  final int totalExpense;
  final int deliveryCharge;
  final String? couponName;
  final bool paymentStatus;
  final String deliveryMethod;
  final String orderStatus;
  final String orderTime;
  final String billerID;
  final String receiverName;
  final String receiverContactNumber;
  final String receiverEmail;
  CustomOrderModel({
    required this.orderID,
    required this.color,
    required this.size,
    required this.quantity,
    required this.totalExpense,
    required this.deliveryCharge,
    this.couponName,
    required this.paymentStatus,
    required this.deliveryMethod,
    required this.orderStatus,
    required this.orderTime,
    required this.billerID,
    required this.receiverName,
    required this.receiverContactNumber,
    required this.receiverEmail,
  });

  CustomOrderModel copyWith({
    String? orderID,
    String? color,
    String? size,
    int? quantity,
    int? totalExpense,
    int? deliveryCharge,
    String? couponName,
    bool? paymentStatus,
    String? deliveryMethod,
    String? orderStatus,
    String? orderTime,
    String? billerID,
    String? receiverName,
    String? receiverContactNumber,
    String? receiverEmail,
  }) {
    return CustomOrderModel(
      orderID: orderID ?? this.orderID,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      totalExpense: totalExpense ?? this.totalExpense,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      couponName: couponName ?? this.couponName,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      orderStatus: orderStatus ?? this.orderStatus,
      orderTime: orderTime ?? this.orderTime,
      billerID: billerID ?? this.billerID,
      receiverName: receiverName ?? this.receiverName,
      receiverContactNumber: receiverContactNumber ?? this.receiverContactNumber,
      receiverEmail: receiverEmail ?? this.receiverEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'color': color,
      'size': size,
      'quantity': quantity,
      'totalExpense': totalExpense,
      'deliveryCharge': deliveryCharge,
      'couponName': couponName,
      'paymentStatus': paymentStatus,
      'deliveryMethod': deliveryMethod,
      'orderStatus': orderStatus,
      'orderTime': orderTime,
      'billerID': billerID,
      'receiverName': receiverName,
      'receiverContactNumber': receiverContactNumber,
      'receiverEmail': receiverEmail,
    };
  }

  factory CustomOrderModel.fromMap(Map<String, dynamic> map) {
    return CustomOrderModel(
      orderID: map['orderID'] as String,
      color: map['color'] as String,
      size: map['size'] as String,
      quantity: map['quantity'] as int,
      totalExpense: map['totalExpense'] as int,
      deliveryCharge: map['deliveryCharge'] as int,
      couponName: map['couponName'] != null ? map['couponName'] as String : null,
      paymentStatus: map['paymentStatus'] as bool,
      deliveryMethod: map['deliveryMethod'] as String,
      orderStatus: map['orderStatus'] as String,
      orderTime: map['orderTime'] as String,
      billerID: map['billerID'] as String,
      receiverName: map['receiverName'] as String,
      receiverContactNumber: map['receiverContactNumber'] as String,
      receiverEmail: map['receiverEmail'] as String,
    );
  }
}
