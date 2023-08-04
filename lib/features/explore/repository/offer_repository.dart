import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/core/constants/firebase_constants.dart';
import 'package:tcean/core/providers/firebase_providers.dart';
import 'package:tcean/models/coupon_model.dart';

final offerRepositoryProvider = Provider<OfferRepository>(
    (ref) => OfferRepository(firestore: ref.read(firestoreProvider)));

class OfferRepository {
  final FirebaseFirestore _firestore;

  OfferRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _offers =>
      _firestore.collection(FirebaseConstants.couponsCollection);

  Stream<List<CouponModel>> getOffersData() {
    return _offers.snapshots().map((event) => event.docs
        .map((e) => CouponModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }
}
