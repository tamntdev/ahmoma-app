import 'package:ahmoma_app/utils/local_storage/app_local_storages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppCubit extends Cubit<ThemeMode> {
  MyAppCubit() : super(_getInitialThemeMode());

  static ThemeMode _getInitialThemeMode() {
    final savedTheme = AppLocalStorage().read('themeMode') ?? 'system';
    switch (savedTheme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void updateThemeMode(ThemeMode themeMode) {
    AppLocalStorage().save(key: 'themeMode', value: themeMode.toString().split('.').last);
    emit(themeMode);
  }
}
