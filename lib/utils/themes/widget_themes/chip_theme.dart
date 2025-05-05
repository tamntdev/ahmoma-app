import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppChipTheme {
  AppChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: AppColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: AppColors.black),
    selectedColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: AppColors.white,
  );

  static var darkChipTheme = const ChipThemeData(
    disabledColor: AppColors.grey,
    labelStyle: TextStyle(color: AppColors.white),
    selectedColor: AppColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: AppColors.white,
  );
}
