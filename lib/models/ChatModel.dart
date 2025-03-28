import 'package:training_app/models/ChatCardModel.dart';
import 'package:training_app/models/UserModel.dart';

class ChatModel {
  final ChatCardModel chatData;
  final UserModel contact;

  ChatModel({
    required this.chatData,
    required this.contact,
  });
}