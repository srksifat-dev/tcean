import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/core/constants/firebase_constants.dart';
import 'package:tcean/core/providers/firebase_providers.dart';
import 'package:tcean/core/providers/isar_provider.dart';
import 'package:tcean/core/type_defs.dart';
import 'package:tcean/main.dart';
import 'package:tcean/models/notification_model.dart';

// final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
//   return NotificationRepository(db: ref.watch(isarProvider.future));
// });

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(firestore: ref.read(firestoreProvider));
});

class NotificationRepository {
  final FirebaseFirestore _firestore;
  NotificationRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _notifications =>
      _firestore.collection(FirebaseConstants.notifications);

  // Read
  Stream<List<NotificationModel>> getNotifications() {
    return _notifications
        .where(Filter.or(
            Filter.and(Filter("isPersonal", isEqualTo: true),
                Filter("userID", isEqualTo: userModel!.uid)),
            Filter("isPersonal", isEqualTo: false)))
        .snapshots()
        .map((event) => event.docs
            .map((e) =>
                NotificationModel.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }
}
