import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCardModel {
  final String id;
  final List<String> users;
  final List<String> usersTyping;
  final String lastMessage;
  final DateTime? timestamp;

  ChatCardModel({
    required this.id,
    required this.users,
    required this.lastMessage,
    required this.timestamp,
    required this.usersTyping,
  });

  factory ChatCardModel.fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) {
    return ChatCardModel(
      id: id,
      users: List<String>.from(json['users']),
      usersTyping: List<String>.from(json['usersTyping']),
      lastMessage: json['lastMessage'] ?? '',
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  factory ChatCardModel.fromDoc({required DocumentSnapshot doc}) {
    return ChatCardModel.fromJson(
      id: doc.id,
      json: doc.data() as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users': users,
      'usersTyping': usersTyping,
      'lastMessage': lastMessage,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }

  String getContactId(String myUid) {
    return users.firstWhere((uid) => uid != myUid);
  }
}
