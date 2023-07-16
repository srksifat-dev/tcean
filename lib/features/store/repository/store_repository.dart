import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcean/core/constants/firebase_constants.dart';
import 'package:tcean/models/product_model.dart';

class StoreRepository {
  final FirebaseFirestore _firestore;
  StoreRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productsCollection);

  Stream<List<ProductModel>> getProductsData() {
    return _products.snapshots().map((event) => event.docs
        .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }
}
