

class ProductModel {
  final String productID;
  final String productName;
  final String description;
  final int price;
  final List<String> productImageUrls;
  final List<String> categories;
  final String productCreated;
  final int sellNumber;
  final String productLabel;
  ProductModel({
    required this.productID,
    required this.productName,
    required this.description,
    required this.price,
    required this.productImageUrls,
    required this.categories,
    required this.productCreated,
    required this.sellNumber,
    required this.productLabel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'productName': productName,
      'description': description,
      'price': price,
      'productImageUrls': productImageUrls,
      'categories': categories,
      'productCreated': productCreated,
      'sellNumber': sellNumber,
      'productLabel': productLabel,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productID: map["productID"],
      productName: map["productName"],
      description: map["description"],
      price: map["price"],
      productImageUrls: (map["productImageUrls"] as List).cast<String>(),
      categories: (map["categories"] as List).cast<String>(),
      productCreated: map["productCreated"],
      sellNumber: map["sellNumber"],
      productLabel: map["productLabel"],
    );
  }
}
