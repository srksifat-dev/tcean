import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tcean/core/constants/firebase_constants.dart';

import '../failure.dart';
import '../type_defs.dart';
import 'firebase_providers.dart';

final storageRepositoryProvider = Provider(
    (ref) => StorageRepository(firebaseStorage: ref.watch(storageProvider)));

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  FutureEither<List<String>> storeProductFiles(
      {required String productID, required List<Uint8List> files}) async {
    List<String> urls = [];
    try {
      final ref = _firebaseStorage.ref("products").child(productID);
      final metaData = SettableMetadata(contentType: 'image/jpeg');
      for (Uint8List? file in files) {
        UploadTask uploadTask = ref.putData(file!, metaData);
        final snapshot = await uploadTask;
        urls.add(await snapshot.ref.getDownloadURL());
      }
      return right(urls);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<List<String>> storeCustomOrderFiles(
      {required String customOrderID, required List<Uint8List> files}) async {
    List<String> urls = [];
    try {
      final ref = _firebaseStorage.ref(FirebaseConstants.customOrdersCollection).child(customOrderID);
      final metaData = SettableMetadata(contentType: 'image/jpeg');
      for (Uint8List? file in files) {
        UploadTask uploadTask = ref.putData(file!, metaData);
        final snapshot = await uploadTask;
        urls.add(await snapshot.ref.getDownloadURL());
      }
      return right(urls);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
