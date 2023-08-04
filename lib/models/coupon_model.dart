

List<String> couponTypes = [
  "moneyDiscount",
  "percentDiscount",
  "freeShipping",
  "salePrice",
  "buyXGetYFree"
];

List<String> applyTos = [
  "All Products",
  "Specific Product",
  "Specific Category",
  "Minimum Order Subtotal"
      "All Orders"
];

List<String> couponStatus = ["active", "non active", "scheduled", "expired"];

class CouponModel {
  final String couponID;
  final String couponName;
  final String couponType;
  final String couponCode;
  final int? discountAmount;
  final int? discountPercent;
  final int? salePrice;
  final int? buyQuantity;
  final int? getQuantity;
  final int? limitOfUses;
  final int uses;
  final bool isOneUsePerCustomer;
  final String applyTo;
  bool visibility;
  final int? minimumOrder;
  final String? productName;
  final String? categoryName;
  CouponModel({
    required this.couponID,
    required this.couponName,
    required this.couponType,
    required this.couponCode,
    this.discountAmount,
    this.discountPercent,
    this.salePrice,
    this.buyQuantity,
    this.getQuantity,
    this.limitOfUses,
    required this.uses,
    required this.isOneUsePerCustomer,
    required this.applyTo,
    required this.visibility,
    this.minimumOrder,
    this.categoryName,
    this.productName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "couponID": couponID,
      'couponName': couponName,
      'couponType': couponType,
      'couponCode': couponCode,
      'discountAmount': discountAmount,
      'discountPercent': discountPercent,
      'salePrice': salePrice,
      'buyQuantity': buyQuantity,
      'getQuantity': getQuantity,
      'limitOfUses': limitOfUses,
      'uses': uses,
      'isOneUsePerCustomer': isOneUsePerCustomer,
      'applyTo': applyTo,
      'visibility': visibility,
      "minimumOrder": minimumOrder,
      "productName": productName,
      "categoryName": categoryName,
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      couponID: map["couponID"] as String,
      couponName: map['couponName'] as String,
      couponType: map['couponType'] as String,
      couponCode: map['couponCode'] as String,
      discountAmount:
          map['discountAmount'] != null ? map['discountAmount'] as int : null,
      discountPercent:
          map['discountPercent'] != null ? map['discountPercent'] as int : null,
      salePrice: map['salePrice'] != null ? map['salePrice'] as int : null,
      buyQuantity:
          map['buyQuantity'] != null ? map['buyQuantity'] as int : null,
      getQuantity:
          map['getQuantity'] != null ? map['getQuantity'] as int : null,
      limitOfUses:
          map['limitOfUses'] != null ? map['limitOfUses'] as int : null,
      uses: map['uses'] as int,
      isOneUsePerCustomer: map['isOneUsePerCustomer'] as bool,
      applyTo: map['applyTo'] as String,
      visibility: map['visibility'] as bool,
      minimumOrder:
          map["minimumOrder"] != null ? map["minimumOrder"] as int : null,
          productName: map["productName"] != null ? map["productName"] as String : null,
          categoryName: map["categoryName"] != null? map["categoryName"] as String : null,
    );
  }
}
