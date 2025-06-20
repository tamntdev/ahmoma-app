import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

/// Light & Dark Button Theme
class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  /// Light theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      // foregroundColor: Colors.white,
      // backgroundColor: const Color(0xFF1769aa),
      // disabledForegroundColor: Colors.grey,
      // disabledBackgroundColor: Colors.grey,
      // side: const BorderSide(color: Color(0xFF1769aa)),
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.buttonHeight,
        horizontal: 20,
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      // foregroundColor: Colors.white,
      // backgroundColor: const Color(0xFF1769aa),
      // disabledForegroundColor: Colors.grey,
      // disabledBackgroundColor: Colors.grey,
      // side: const BorderSide(color: Color(0xFF1769aa)),
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.buttonHeight,
        horizontal: 20,
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
    ),
  );
}
