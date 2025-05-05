import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:ahmoma_app/utils/themes/widget_themes/appbar_theme.dart';
import 'package:ahmoma_app/utils/themes/widget_themes/bottom_sheet_theme.dart';
import 'package:ahmoma_app/utils/themes/widget_themes/checkbox_theme.dart';
import 'package:ahmoma_app/utils/themes/widget_themes/chip_theme.dart';
import 'package:ahmoma_app/utils/themes/widget_themes/elevated_button_theme.dart';
import 'package:ahmoma_app/utils/themes/widget_themes/outlined_button_theme.dart';
import 'package:ahmoma_app/utils/themes/widget_themes/text_field_theme.dart';
import 'package:ahmoma_app/utils/themes/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'BeVietNamPro',
    disabledColor: AppColors.grey,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
    dividerColor: Colors.transparent,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'BeVietNamPro',
    disabledColor: AppColors.grey,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
    dividerColor: Colors.transparent,
  );
}
