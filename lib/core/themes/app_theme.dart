import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/themes/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    useMaterial3: true,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.onBackground),
      bodyMedium: TextStyle(color: AppColors.onBackground),
      bodySmall: TextStyle(color: AppColors.onBackground),
    ),
  );
}
