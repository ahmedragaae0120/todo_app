import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    navigationBarTheme: const NavigationBarThemeData(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.onPrimryLightColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: const IconThemeData(size: 30),
        selectedIconTheme:
            IconThemeData(size: 30, color: appColors.primryLightColor)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: appColors.primryLightColor,
        shape: const CircleBorder(),
        extendedPadding: const EdgeInsets.all(30)),
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
    indicatorColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    // brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: appColors.primryDarkColor,
      primary: appColors.primryDarkColor,
      onPrimary: appColors.onPrimryDarkColor,
      secondary: appColors.secoundDarkColor,
      onSecondary: appColors.onSecoundDarkColor,
      tertiary: appColors.easyDateColorDark,
      onTertiary: Colors.white,
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: appColors.onSecoundDarkColor)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.primryDarkColor,
        selectedLabelStyle: TextStyle(color: appColors.onSecoundDarkColor),
        unselectedLabelStyle: TextStyle(color: appColors.onSecoundDarkColor),
        unselectedItemColor: appColors.onSecoundDarkColor,
        unselectedIconTheme:
            IconThemeData(size: 30, color: appColors.onPrimryDarkColor),
        selectedIconTheme: const IconThemeData(size: 30, color: Colors.white)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: appColors.secoundDarkColor,
        shape: const CircleBorder(),
        extendedPadding: const EdgeInsets.all(30)),
    appBarTheme: AppBarTheme(
      toolbarHeight: 50,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: appColors.onSecoundDarkColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      foregroundColor: appColors.onPrimryDarkColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: appColors.primryDarkColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
    ),
    textTheme: TextTheme(
        bodyLarge:
            appColors.titleTask.copyWith(color: appColors.primryDarkColor),
        // bodyMedium: appColors.DoneTask,
        bodySmall: appColors.smallText),
    useMaterial3: false,
    datePickerTheme: DatePickerThemeData(
      backgroundColor: appColors.primryDarkColor,
      dayStyle: const TextStyle(color: Colors.yellow, fontSize: 20),
      // dayOverlayColor: WidgetStatePropertyAll(appColors.secoundDarkColor),
      todayForegroundColor: const WidgetStatePropertyAll(Colors.red),
      weekdayStyle: const TextStyle(color: Colors.white),
      dayBackgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      yearStyle: const TextStyle(color: Colors.white),
      headerBackgroundColor: appColors.secoundDarkColor,
      headerHeadlineStyle: const TextStyle(color: Colors.white),
      yearForegroundColor: const WidgetStatePropertyAll(Colors.white),

      dayForegroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return appColors.secoundDarkColor; // لون النص للأيام المحددة
          } else if (states.contains(WidgetState.disabled)) {
            return Colors.grey; // لون النص للأيام المعطلة
          }
          return Colors.white; // لون النص للأيام العادية
        },
      ),
    ),
  );
}


  // dayBackgroundColor:
  //         const WidgetStatePropertyAll(Color.fromARGB(88, 0, 0, 0)),
  //     dayStyle: TextStyle(color: appColors.onSecoundDarkColor),
  //     dividerColor: Colors.white,
  //     dayForegroundColor: const WidgetStatePropertyAll(Colors.white),
  //     confirmButtonStyle: ButtonStyle(
  //         backgroundColor: WidgetStatePropertyAll(appColors.secoundDarkColor),
  //         textStyle:
  //             const WidgetStatePropertyAll(TextStyle(color: Colors.white))),
  //     cancelButtonStyle: ButtonStyle(
  //         backgroundColor:
  //             const WidgetStatePropertyAll(Color.fromARGB(137, 244, 67, 54)),
  //         textStyle: WidgetStatePropertyAll(
  //             TextStyle(color: appColors.secoundDarkColor))),
  //     dayOverlayColor: WidgetStatePropertyAll(appColors.secoundDarkColor),
  //     shape: const RoundedRectangleBorder(),
  //     rangePickerHeaderBackgroundColor: Colors.amber,
  //     rangeSelectionBackgroundColor: appColors.secoundDarkColor,
  //     rangeSelectionOverlayColor: const WidgetStatePropertyAll(Colors.white),
  //     headerBackgroundColor: appColors.primryDarkColor,
  //     headerHelpStyle: const TextStyle(color: Colors.white),
  //     surfaceTintColor: Colors.white,
  //     weekdayStyle: const TextStyle(color: Colors.white),
  //     todayForegroundColor: WidgetStatePropertyAll(appColors.secoundDarkColor),
  //     yearStyle: const TextStyle(color: Colors.white),
  //     yearOverlayColor: const WidgetStatePropertyAll(Colors.white),
  //     inputDecorationTheme: const InputDecorationTheme(iconColor: Colors.white),
  //     yearBackgroundColor: const WidgetStatePropertyAll(Colors.white),
  //     rangePickerSurfaceTintColor: Colors.white,
  //     rangePickerHeaderHeadlineStyle: const TextStyle(color: Colors.white),
  //     headerForegroundColor: Colors.white,
