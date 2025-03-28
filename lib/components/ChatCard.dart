import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:training_app/app/AppColors.dart';

class ChatCard extends StatelessWidget {
  final String uuid;
  final String name;
  final String? lastMessage;
  final String? date;
  final void Function()? onLongPress;
  final void Function()? onTap;
  const ChatCard({
    super.key,
    required this.uuid,
    required this.name,
    this.lastMessage,
    this.date,
    this.onLongPress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    RandomAvatar(
                      uuid,
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.fontColor,
                            ),
                          ),
                          Text(
                            lastMessage ?? '',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      date ?? '',
                      style: const TextStyle(
                        color: Color(0xFF58616A),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 15,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
