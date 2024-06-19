import 'package:flutter/material.dart';

class appColors {
  static Color primryLightColor = Color(0xff5D9CEC);
  static Color primryDarkColor = Color(0xff5D9CEC);
  static Color onPrimryLightColor = Colors.white;
  static Color onPrimryDarkColor = Colors.white;
  static Color secoundLightColor = Colors.white;
  static Color secoundDarkColor = Color(0xff141922);
  static Color onSecoundLightColor = Colors.black;
  static Color onSecoundDarkColor = Colors.white;
  static const Color backgroundColor = Color(0xffDFECDB);
  static const Color backgroundColorDark = Color(0xff060e1e);
  static const Color removeTaskbackground = Colors.redAccent;
  static const Color Donetask = Color(0xff61E757);
  static const Color easyDateColor = Colors.white;
  static const Color easyDateColorDark = Color(0xff141922);
  static TextStyle titleTask = TextStyle(
    color: primryLightColor,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static TextStyle DoneTask = const TextStyle(
    color: Donetask,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
  static TextStyle dateStyle = TextStyle(
    color: onSecoundLightColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
