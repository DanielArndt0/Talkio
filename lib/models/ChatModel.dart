import 'package:talkio/models/ChatCardModel.dart';
import 'package:talkio/models/UserModel.dart';

class ChatModel {
  final ChatCardModel chatData;
  final UserModel contact;

  ChatModel({
    required this.chatData,
    required this.contact,
  });
}