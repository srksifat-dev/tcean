import '../../../models/product_model.dart';

List<ProductModel> bestSellingProducts(
    {required List<ProductModel> productModels}) {
  List<ProductModel> bestSelling = [];
  productModels.sort((a, b) => b.sellNumber.compareTo(a.sellNumber));
  for (ProductModel p in productModels) {
    if (bestSelling.length < 20) {
      bestSelling.add(p);
    }
  }

  return bestSelling;
}
