import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTabBarTheme {
  AppTabBarTheme._();

  static final lightTabBarTheme = TabBarThemeData(
    splashBorderRadius: BorderRadius.circular(24),
    labelStyle: const TextStyle(
      overflow: TextOverflow.clip,
      fontWeight: FontWeight.w700,
      fontSize: AppSizes.fontSizeMd,
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
    indicator: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.primary, AppColors.primary1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.textPrimary,
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontSize: AppSizes.fontSizeMd,
    ),
  );

  static final darkTabBarTheme = TabBarThemeData(
    splashBorderRadius: BorderRadius.circular(24),
    labelStyle: const TextStyle(
      overflow: TextOverflow.clip,
      fontWeight: FontWeight.w700,
      fontSize: AppSizes.fontSizeMd,
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
    indicator: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.primary, AppColors.primary1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.textPrimary,
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontSize: AppSizes.fontSizeMd,
    ),
  );
}
