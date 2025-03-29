import 'package:flutter/material.dart';
import 'package:talkio/app/AppColors.dart';
import 'package:talkio/controllers/HomeController.dart';
import 'package:talkio/models/ChatModel.dart';

class DeleteChatModal extends StatelessWidget {
  final HomeController controller;
  final ChatModel chat;
  const DeleteChatModal({
    super.key,
    required this.controller,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: const Text(
        'Do you want to remove this chat?',
      ),
      actions: [
        ElevatedButton(
          onPressed: () => controller.onChatCardLongPress(chatData: chat),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryMaterialColor,
          ),
          child: const Text(
            'Remove',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: controller.cancelRemoveContact,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
