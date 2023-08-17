import 'package:isar/isar.dart';
part 'notification_model.g.dart';

@Collection()
class NotificationModel {
  final Id notificationId = Isar.autoIncrement;
  late String title;
  late String body;
  late String dateTime;
}
