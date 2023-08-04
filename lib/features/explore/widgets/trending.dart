import '../../../models/product_model.dart';

List<ProductModel> trending({required List<ProductModel> productModels}){
List<ProductModel> trending = [];
  productModels.sort((a, b) => b.viewTimes.compareTo(a.viewTimes));
  for (ProductModel p in productModels) {
    if (trending.length < 20) {
      trending.add(p);
    }
  }

  return trending;
}