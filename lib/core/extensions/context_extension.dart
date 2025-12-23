import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/themes/app_colors.dart';

extension ContextExtension on BuildContext {
  /// Sizes
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  /// Colors
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  /// TextStyles
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;
  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;
  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleTextStyle => Theme.of(this).appBarTheme.titleTextStyle;

  ///ViewInsets
  bool get keyBoardVisibility => MediaQuery.of(this).viewInsets.bottom != 0;

  // hide keyboard
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  void showSnack(
    String message, {
    Color? color,
    double? fontSize,
    bool? isError,
    String? actionLabel,
    void Function()? action,
    bool? actionEnabled,
    bool? isPinned,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: titleMedium?.copyWith(
            color: AppColors.background,
            fontSize: fontSize ?? 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        action: actionEnabled ?? false
            ? SnackBarAction(
                label: actionLabel ?? 'Dismiss',
                onPressed: action ?? () {},
                textColor: AppColors.background,
              )
            : null,
        duration: isPinned ?? false
            ? const Duration(days: 1)
            : const Duration(seconds: 4),
        backgroundColor: (isError ?? false)
            ? Colors.redAccent
            : color ?? AppColors.primary,
      ),
    );
  }
}
