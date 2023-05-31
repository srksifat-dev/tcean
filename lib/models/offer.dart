class Offer {
  final String offerID;
  final String name;
  final int? percentage;
  final int? money;
  final List<String>? productID;
  final String? couponID;

  Offer({required this.offerID,required this.name,this.percentage, this.money, this.productID, this.couponID});

}
