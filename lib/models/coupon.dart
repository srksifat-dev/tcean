List<String> couponTypes = [
  "moneyDiscount",
  "percentDiscount",
  "freeShipping",
  "salePrice",
  "buyXGetYFree"
];

List<String> couponStatus = ["active", "non active", "scheduled", "expired"];

class Coupon {
  final String couponName;
  final String couponType;
  final String couponCode;
  final String startDate;
  final String? endDate;
  final int? discountAmount;
  final int? discountPercent;
  final int? salePrice;
  final int? buyQuantity;
  final int? getQuantity;
  final int? limitOfUses;
  final int uses;
  final bool? isOneUsePerCustomer;
  final String applyTo;
  final String couponStatus;

  Coupon({
    required this.couponName,
    required this.couponType,
    required this.couponCode,
    required this.startDate,
    required this.applyTo,
    required this.couponStatus,
    required this.uses,
    this.salePrice,
    this.endDate,
    this.buyQuantity,
    this.getQuantity,
    this.limitOfUses,
    this.discountAmount,
    this.discountPercent,
    this.isOneUsePerCustomer,
  });
}
