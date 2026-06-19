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
    inputDecorationTheme: _inputDecorationTheme,
    filledButtonTheme: _filledButtonTheme,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white,),
  );

  static final ThemeData _darkThemeData = ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    brightness: Brightness.light,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.themeColor,
    ),
    inputDecorationTheme: _inputDecorationTheme,
    filledButtonTheme: _filledButtonTheme,

    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
      labelLarge: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
    ),
  );

  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    contentPadding: .only(left: 12),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeColor,width: 12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeColor, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
  );

  static final FilledButtonThemeData _filledButtonTheme=FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.themeColor,
      fixedSize: Size.fromWidth(double.maxFinite),
      shape: RoundedRectangleBorder(borderRadius: .circular(8)),
    ),
  );
}