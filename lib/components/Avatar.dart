import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class Avatar extends StatelessWidget {
  final String uuid;
  final Color? color;
  const Avatar({
    super.key,
    required this.uuid,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RandomAvatar(uuid),
        Positioned(
          bottom: 2.5,
          right: 0,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? Colors.green,
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
