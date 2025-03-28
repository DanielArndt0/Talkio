import 'package:flutter/material.dart';
import 'package:training_app/app/AppColors.dart';

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
