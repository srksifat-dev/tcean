// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationModel {
  final String notificationID;
  final bool isPersonal;
  String? userID;
  final String title;
  final String body;
  final String dateTime;
  NotificationModel({
    required this.notificationID,
    required this.isPersonal,
    this.userID,
    required this.title,
    required this.body,
    required this.dateTime,
  });


  NotificationModel copyWith({
    String? notificationID,
    bool? isPersonal,
    String? userID,
    String? title,
    String? body,
    String? dateTime,
  }) {
    return NotificationModel(
      notificationID: notificationID ?? this.notificationID,
      isPersonal: isPersonal ?? this.isPersonal,
      userID: userID ?? this.userID,
      title: title ?? this.title,
      body: body ?? this.body,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notificationID': notificationID,
      'isPersonal': isPersonal,
      'userID': userID,
      'title': title,
      'body': body,
      'dateTime': dateTime,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      notificationID: map['notificationID'] as String,
      isPersonal: map['isPersonal'] as bool,
      userID: map['userID'] != null ? map['userID'] as String : null,
      title: map['title'] as String,
      body: map['body'] as String,
      dateTime: map['dateTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(notificationID: $notificationID, isPersonal: $isPersonal, userID: $userID, title: $title, body: $body, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.notificationID == notificationID &&
      other.isPersonal == isPersonal &&
      other.userID == userID &&
      other.title == title &&
      other.body == body &&
      other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return notificationID.hashCode ^
      isPersonal.hashCode ^
      userID.hashCode ^
      title.hashCode ^
      body.hashCode ^
      dateTime.hashCode;
  }
}
