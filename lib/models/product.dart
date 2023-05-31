class Product {
  final String productID;
  final String productName;
  final List<String> productImageUrls;
  List<String> categories = ["All"];
  final String productCreated;

  Product({
    required this.productCreated,
    required this.productID,
    required this.productName,
    required this.productImageUrls,
    required this.categories,
  });
}
