import 'package:flutter/material.dart';
import 'package:talkio/app/AppColors.dart';

class TalkioLogo extends StatelessWidget {
  final double? size;
  const TalkioLogo({this.size = 60, super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Talkio',
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: AppColors.fontColor,
        ),
        children: [
          TextSpan(
            text: '.',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
