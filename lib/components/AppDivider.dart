import 'package:flutter/material.dart';
import 'package:talkio/app/AppColors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.searchBarColor,
          ),
        ),
      ],
    );
  }
}
