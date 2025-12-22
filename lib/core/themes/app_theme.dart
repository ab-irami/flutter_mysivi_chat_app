import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/themes/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextTheme(),
  );
}
