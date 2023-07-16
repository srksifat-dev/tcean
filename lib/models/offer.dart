class Offer {
  final String offerID;
  final String title;
  final String? subtitle;
  final int? percentage;
  final int? money;
  final List<String>? productsID;
  final List<String>? categoriesID;
  final String couponID;

  Offer(
      {required this.offerID,
      required this.title,
      this.subtitle,
      this.percentage,
      this.money,
      this.productsID,
      this.categoriesID,
      required this.couponID,});
}
