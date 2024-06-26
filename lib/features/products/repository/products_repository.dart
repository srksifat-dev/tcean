import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/core/constants/firebase_constants.dart';
import 'package:tcean/core/providers/firebase_providers.dart';
import 'package:tcean/models/product_model.dart';

final productsRepositoryProvider = Provider<ProductsRepository>(
    (ref) => ProductsRepository(firestore: ref.read(firestoreProvider)));

class ProductsRepository {
  final FirebaseFirestore _firestore;
  ProductsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productsCollection);

  Stream<List<ProductModel>> getProductsData() {
    return _products.snapshots().map((event) => event.docs
        .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<ProductModel> getProductByID(String productID) {
    return _products.doc(productID).snapshots().map(
        (event) => ProductModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Stream<ProductModel> getProductByName(String productName) {
    return _products
        .where("productName", isEqualTo: productName)
        .snapshots()
        .map((event) => ProductModel.fromMap(event as Map<String, dynamic>));
  }

  Stream<List<ProductModel>> getProductsByCategoryName(String categoryName) {
    return _products
        .where("categories", arrayContains: categoryName)
        .snapshots()
        .map((event) => event.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }
}
