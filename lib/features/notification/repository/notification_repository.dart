
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:tcean/core/providers/isar_provider.dart';
import 'package:tcean/models/notification_model.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(db: ref.watch(isarProvider.future));
});

class NotificationRepository {
  final Future<Isar> _db;

  NotificationRepository({required Future<Isar> db}) : _db = db;

  // Read Notifications
  Stream<List<NotificationModel>> getNotifications() async* {
    final isar = await _db;

    yield* isar.notificationModels.where().watch(fireImmediately: true);
  }
}
