import 'package:crafty_bay/features/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData get lightTheme => _lightThemeData;
  static ThemeData get darkTheme => _darkThemeData;

  static final ThemeData _lightThemeData = ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.themeColor,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  static final ThemeData _darkThemeData = ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    brightness: Brightness.light,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.themeColor,
    ),
  );
}