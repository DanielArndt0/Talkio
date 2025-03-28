import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_app/controllers/NavigationController.dart';
import 'package:training_app/controllers/PrivateChatController.dart';
import 'package:training_app/errors/CloudException.dart';
import 'package:training_app/models/ChatModel.dart';
import 'package:training_app/models/MessageModel.dart';
import 'package:training_app/services/AuthService.dart';
import 'package:training_app/services/CloudDBService.dart';

class PrivateChatControllerImpl extends PrivateChatController {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _messageScrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final String? _chatId;
  late final String? _contactId;
  Timer? _typingTimer;

  PrivateChatControllerImpl({
    required this.authService,
    required this.cloudDbService,
    required this.navigationController,
  });

  late final AuthService authService;
  late final CloudDBService cloudDbService;
  late final NavigationController navigationController;

  @override
  String? get chatId => _chatId;

  @override
  String? get contactId => _contactId;

  @override
  TextEditingController get messageController => _messageController;

  @override
  GlobalKey<FormState> get messageFieldKey => _formKey;

  @override
  ScrollController get messageScrollController => _messageScrollController;

  @override
  Stream<QuerySnapshot> loadMessages({required ChatModel chat}) {
    return cloudDbService.getMessages(chatId: chat.chatData.id);
  }

  @override
  Future<void> sendMessage({required ChatModel chatData}) async {
    if (messageFieldKey.currentState!.validate()) {
      await cloudDbService.sendMessage(
        userId: authService.currentUser.uid,
        contactId: chatData.contact.id,
        text: messageController.text,
      );
      messageController.text = '';
      cloudDbService.setTyping(
        chatId: chatData.chatData.id,
        userId: authService.currentUser.uid,
        isTyping: false,
      );
    }
  }

  @override
  void onNewMessage({required MessageModel message}) async {
    _scrollToBottom();
    _vibrateOnNewMessage(message);
  }

  @override
  Future<void> messageOnChanged({required ChatModel chatData}) async {
    final isTyping = messageController.text.isNotEmpty;
    cloudDbService.setTyping(
      chatId: chatData.chatData.id,
      userId: authService.currentUser.uid,
      isTyping: isTyping,
    );

    _typingTimer?.cancel();
    if (isTyping) {
      _typingTimer = Timer(
        const Duration(seconds: 3),
        () {
          cloudDbService.setTyping(
            chatId: chatData.chatData.id,
            userId: authService.currentUser.uid,
            isTyping: false,
          );
        },
      );
    }
  }

  void _scrollToBottom() {
    if (messageScrollController.hasClients) {
      final maxScroll = messageScrollController.position.maxScrollExtent;
      final currentScroll = messageScrollController.position.pixels;
      final distanceFromBottom = maxScroll - currentScroll;

      if (distanceFromBottom < 100) {
        messageScrollController.animateTo(
          messageScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  void _vibrateOnNewMessage(MessageModel message) {
    if (message.userId != authService.currentUser.uid) {
      HapticFeedback.vibrate();
    }
  }

  @override
  Stream<DocumentSnapshot> contactIsTyping({
    required ChatModel chatData,
  }) {
    return cloudDbService.getChatStream(chatId: chatData.chatData.id);
  }

  @override
  Future<void> onMessageLongPress({
    required BuildContext context,
    required ChatModel chat,
    required MessageModel message,
    required LongPressStartDetails details,
  }) async {
    HapticFeedback.vibrate();

    List<PopupMenuItem> menuList = [
      PopupMenuItem(
        child: const Text('Copy'),
        onTap: () {
          Clipboard.setData(
            ClipboardData(text: message.text),
          );
        },
      ),
    ];
    
    if (message.userId == authService.currentUser.uid) {
      menuList.add(
        PopupMenuItem(
          child: const Text('Delete'),
          onTap: () async {
            try {
              await cloudDbService.deleteMessage(
                userId: authService.currentUser.uid,
                chatId: chat.chatData.id,
                messageId: message.id,
              );
            } on CloudException catch (error) {
              navigationController.showSnackbar(message: error.message);
            } catch (error) {
              navigationController.showSnackbar(message: error.toString());
            }
          },
        ),
      );
    }

    showMenu(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: menuList,
    );
  }
}
