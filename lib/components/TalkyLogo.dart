import 'package:flutter/material.dart';
import 'package:training_app/app/AppColors.dart';

class TalkyLogo extends StatelessWidget {
  final double? size;
  const TalkyLogo({this.size = 60, super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Talky',
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
