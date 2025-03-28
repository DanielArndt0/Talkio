import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String userId;
  final String text;
  final DateTime? timestamp;

  MessageModel({
    required this.id,
    required this.userId,
    required this.text,
    required this.timestamp,
  });

  factory MessageModel.fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) {
    return MessageModel(
      id: id,
      userId: json['userId'],
      text: json['text'] ?? '',
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  factory MessageModel.fromDoc({required DocumentSnapshot doc}) {
    return MessageModel.fromJson(
      id: doc.id,
      json: doc.data() as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'text': text,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }
}
