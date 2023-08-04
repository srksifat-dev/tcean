import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/features/products/repository/products_repository.dart';
import 'package:tcean/models/product_model.dart';

final getProductsProvider = StreamProvider<List<ProductModel>>((ref) {
  final productController = ref.watch(productControllerProvider);
  return productController.getProductsData();
});

final getProductProvider =
    StreamProvider.family<ProductModel, String>((ref, productID) {
  final productController = ref.watch(productControllerProvider);
  return productController.getProductByID(productID);
});

final getProductByNameProvider =
    StreamProvider.family<ProductModel, String>((ref, productName) {
  final productController = ref.watch(productControllerProvider);
  return productController.getProductByName(productName);
});

final productControllerProvider = Provider<ProductsController>((ref) {
  return ProductsController(
    productsRepository: ref.watch(productsRepositoryProvider),
    ref: ref,
  );
});

class ProductsController {
  final ProductsRepository _productsRepository;
  final Ref _ref;

  ProductsController(
      {required ProductsRepository productsRepository, required Ref ref})
      : _productsRepository = productsRepository,
        _ref = ref;

  Stream<List<ProductModel>> getProductsData() {
    return _productsRepository.getProductsData();
  }

  Stream<ProductModel> getProductByID(String productID) {
    return _productsRepository.getProductByID(productID);
  }

  Stream<ProductModel> getProductByName(String productName) {
    return _productsRepository.getProductByName(productName);
  }

  Stream<List<ProductModel>> getProductsByCategoryName(String categoryName) {
    return _productsRepository.getProductsByCategoryName(categoryName);
  }
}
