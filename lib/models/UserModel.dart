import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) {
    return UserModel(
      id: id,
      name: json['name'],
      email: json['email'],
    );
  }

  factory UserModel.fromDoc({required DocumentSnapshot doc}) {
    return UserModel.fromJson(
      id: doc.id,
      json: doc.data() as Map<String, dynamic>,
    );
  }

  factory UserModel.empty() {
    return UserModel(id: '', name: '', email: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
