import 'package:flutter/material.dart';
import 'package:todo_app/style/app_colors.dart';

class appTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: appColors.primryLightColor,
      primary: appColors.primryLightColor,
      onPrimary: appColors.onPrimryLightColor,
    ),
    appBarTheme: AppBarTheme(
      toolbarHeight: 140,
      backgroundColor: appColors.primryLightColor,
      titleTextStyle: TextStyle(
        color: appColors.onPrimryLightColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      foregroundColor: appColors.onPrimryLightColor,
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
