import 'package:flutter/material.dart';
import 'package:todo_app/style/app_colors.dart';

class appTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: appColors.backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: appColors.primryLightColor,
      primary: appColors.primryLightColor,
      onPrimary: appColors.onPrimryLightColor,
      secondary: appColors.secoundLightColor,
      onSecondary: appColors.onSecoundLightColor,
      tertiary: appColors.easyDateColor,
    ),
    navigationBarTheme: NavigationBarThemeData(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.onPrimryLightColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: IconThemeData(size: 30),
        selectedIconTheme:
            IconThemeData(size: 30, color: appColors.primryLightColor)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: appColors.primryLightColor,
        shape: CircleBorder(),
        extendedPadding: EdgeInsets.all(30)),
    appBarTheme: AppBarTheme(
      backgroundColor: appColors.primryLightColor,
      titleTextStyle: TextStyle(
        color: appColors.onPrimryLightColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      foregroundColor: appColors.onPrimryLightColor,
    ),
    textTheme: TextTheme(
        bodyLarge: appColors.titleTask,
        bodyMedium: appColors.DoneTask,
        bodySmall: appColors.dateStyle),
    useMaterial3: false,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appColors.backgroundColorDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: appColors.primryDarkColor,
      primary: appColors.primryDarkColor,
      onPrimary: appColors.onPrimryDarkColor,
      secondary: appColors.secoundDarkColor,
      onSecondary: appColors.onSecoundDarkColor,
      tertiary: appColors.easyDateColorDark,
      onTertiary: Colors.white,
    ),
    navigationBarTheme: NavigationBarThemeData(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xff141922),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: IconThemeData(size: 30, color: Colors.white),
        selectedIconTheme:
            IconThemeData(size: 30, color: appColors.primryDarkColor)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: appColors.primryDarkColor,
        shape: CircleBorder(),
        extendedPadding: EdgeInsets.all(30)),
    appBarTheme: AppBarTheme(
      backgroundColor: appColors.primryDarkColor,
      titleTextStyle: TextStyle(
        color: appColors.secoundDarkColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      foregroundColor: appColors.onPrimryDarkColor,
    ),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: appColors.secoundDarkColor),
    textTheme: TextTheme(
        bodyLarge:
            appColors.titleTask.copyWith(color: appColors.primryDarkColor),
        bodyMedium: appColors.DoneTask,
        bodySmall: appColors.dateStyle.copyWith(color: Colors.white)),
    useMaterial3: false,
  );
}
