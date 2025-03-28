import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talkio/models/ChatModel.dart';
import 'package:talkio/models/MessageModel.dart';

abstract class PrivateChatController {
  Stream<QuerySnapshot> loadMessages({required ChatModel chat});
  Future<void> sendMessage({required ChatModel chatData});
  void onNewMessage({required MessageModel message});
  Future<void> messageOnChanged({required ChatModel chatData});
  Future<void> onMessageLongPress({
    required BuildContext context,
    required ChatModel chat,
    required MessageModel message,
    required LongPressStartDetails details,
  });
  Stream<DocumentSnapshot> contactIsTyping({required ChatModel chatData});

  TextEditingController get messageController;
  ScrollController get messageScrollController;
  GlobalKey<FormState> get messageFieldKey;
  String? get chatId;
  String? get contactId;
}
