import 'package:flutter/material.dart';
import 'package:training_app/app/AppColors.dart';

class AppTheme {
  static final theme = ThemeData(
    primaryColor: AppColors.primaryColor,
    primarySwatch: AppColors.primaryMaterialColor,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryMaterialColor),
    useMaterial3: true,
  );
}
