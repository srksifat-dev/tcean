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

  // Stream<List<ProductModel>> getProductsData() {
  //   return _products.snapshots().map((event) => event.docs
  //       .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
  //       .toList());
  // }

  Stream<List<ProductModel>> getProductsData() {
    return _products.snapshots().map((event) {
      List<ProductModel> products = [];
      for (var doc in event.docs) {
        print("doc: ${doc.data()}");
        products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      print("products: $products");
      return products;
    });
  }

  Future<ProductModel> getProduct(String productID) async {
    return _products
        .doc(productID)
        .get()
        .then((value) => ProductModel.fromMap(value as Map<String, dynamic>));
  }
}
