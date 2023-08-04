// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatModel {
  final String text;
  final DateTime time;
  final String? uid;
  ChatModel({
    required this.text,
    required this.time,
    this.uid,
  });

  ChatModel copyWith({
    String? text,
    DateTime? time,
    String? uid,
  }) {
    return ChatModel(
      text: text ?? this.text,
      time: time ?? this.time,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'time': time.millisecondsSinceEpoch,
      'uid': uid,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      text: map['text'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }
}
