import 'package:flutter/material.dart';
import 'package:talkio/app/AppColors.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String date;
  final bool isContactMessage;
  final void Function(LongPressStartDetails)? onLongPressStart;
  const MessageBubble({
    super.key,
    required this.message,
    required this.isContactMessage,
    required this.date,
    this.onLongPressStart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: onLongPressStart,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isContactMessage
              ? AppColors.searchBarColor
              : AppColors.primaryMaterialColor,
          borderRadius: isContactMessage
              ? const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
        ),
        child: Column(
          crossAxisAlignment: isContactMessage
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isContactMessage ? AppColors.fontColor : Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    color:
                        isContactMessage ? AppColors.fontColor : Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
