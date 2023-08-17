import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/features/notification/repository/notification_repository.dart';
import 'package:tcean/models/notification_model.dart';

// notification controller provider
final notificationControllerProvider = Provider<NotificationController>((ref) {
  return NotificationController(
      notificationRepository: ref.watch(notificationRepositoryProvider),
      ref: ref);
});

// notifications stream provider
final getNotificationsProvider = StreamProvider<List<NotificationModel>>((ref) {
  final notificationController = ref.watch(notificationControllerProvider);
  return notificationController.getNotifications();
});

class NotificationController {
  final NotificationRepository _notificationRepository;
  final Ref _ref;

  NotificationController(
      {required NotificationRepository notificationRepository,
      required Ref ref})
      : _notificationRepository = notificationRepository,
        _ref = ref;

  // Read Notifications
  Stream<List<NotificationModel>> getNotifications() {
    return _notificationRepository.getNotifications();
  }
}
