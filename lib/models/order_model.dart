

List<String> allOrderStatus = [
  "confirmed",
  "processing",
  "packed",
  "shipped",
  "delivered",
];

List<String> deliveryMethods = ["hd", "scs"];

class OrderModel {
  final String orderID;
  final int orderExpense;
  final int deliveryCharge;
  final String? couponName;
  final bool paymentStatus;
  final String deliveryMethod;
  final String orderStatus;
  final String orderTime;
  final String billerUID;
  final String receiverName;
  final String receiverContactNumber;
  final String receiverEmail;
  OrderModel({
    required this.orderID,
    required this.orderExpense,
    required this.deliveryCharge,
    this.couponName,
    required this.paymentStatus,
    required this.deliveryMethod,
    required this.orderStatus,
    required this.orderTime,
    required this.billerUID,
    required this.receiverName,
    required this.receiverContactNumber,
    required this.receiverEmail,
  });

  OrderModel copyWith({
    String? orderID,
    int? orderExpense,
    int? deliveryCharge,
    String? couponName,
    bool? paymentStatus,
    String? deliveryMethod,
    String? orderStatus,
    String? orderTime,
    String? receiverUID,
    String? receiverName,
    String? receiverContactNumber,
    String? receiverEmail,
  }) {
    return OrderModel(
      orderID: orderID ?? this.orderID,
      orderExpense: orderExpense ?? this.orderExpense,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      couponName: couponName ?? this.couponName,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      orderStatus: orderStatus ?? this.orderStatus,
      orderTime: orderTime ?? this.orderTime,
      billerUID: receiverUID ?? this.billerUID,
      receiverName: receiverName ?? this.receiverName,
      receiverContactNumber:
          receiverContactNumber ?? this.receiverContactNumber,
      receiverEmail: receiverEmail ?? this.receiverEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'orderExpense': orderExpense,
      'deliveryCharge': deliveryCharge,
      'couponName': couponName,
      'paymentStatus': paymentStatus,
      'deliveryMethod': deliveryMethod,
      'orderStatus': orderStatus,
      'orderTime': orderTime,
      'receiverUID': billerUID,
      'receiverName': receiverName,
      'receiverContactNumber': receiverContactNumber,
      'receiverEmail': receiverEmail,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderID: map['orderID'] as String,
      orderExpense: map['orderExpense'] as int,
      deliveryCharge: map['deliveryCharge'] as int,
      couponName:
          map['couponName'] != null ? map['couponName'] as String : null,
      paymentStatus: map['paymentStatus'] as bool,
      deliveryMethod: map['deliveryMethod'] as String,
      orderStatus: map['orderStatus'] as String,
      orderTime: map['orderTime'] as String,
      billerUID: map['receiverUID'] as String,
      receiverName: map['receiverName'] as String,
      receiverContactNumber: map['receiverContactNumber'] as String,
      receiverEmail: map['receiverEmail'] as String,
    );
  }
}
