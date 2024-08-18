import 'package:flutter/material.dart';

class appColors {
  static Color primryLightColor = const Color(0xff5D9CEC);
  static Color primryDarkColor = const Color(0xff363636);
  static Color onPrimryLightColor = Colors.white;
  static Color onPrimryDarkColor = const Color.fromARGB(157, 255, 255, 255);
  static Color secoundLightColor = const Color.fromARGB(157, 255, 255, 255);
  static Color secoundDarkColor = const Color(0xff8687E7);
  static Color onSecoundLightColor = Colors.black;
  static Color onSecoundDarkColor = Colors.white;
  static const Color backgroundColor = Color(0xffDFECDB);
  static const Color backgroundColorDark = Color(0xff060e1e);
  static const Color removeTaskbackground = Colors.redAccent;
  static const Color Donetask = Color(0xff61E757);
  static const Color easyDateColor = Colors.white;
  static const Color easyDateColorDark = Colors.black87;
  static TextStyle titleTask = TextStyle(
    color: primryLightColor,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static TextStyle DoneTask = const TextStyle(
    color: Colors.blue,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
  static TextStyle dateStyle = TextStyle(
    color: onSecoundLightColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle smallText = const TextStyle(
    color: Color(0xff535353),
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
