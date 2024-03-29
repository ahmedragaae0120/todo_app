import 'package:flutter/material.dart';

class appColors {
  static Color primryLightColor = Color(0xff5D9CEC);
  static Color onPrimryLightColor = Colors.white;
  static Color secoundLightColor = Colors.white;
  static Color onSecoundLightColor = Colors.black;
  static const Color backgroundColor = Color(0xffDFECDB);
  static const Color removeTaskbackground = Colors.redAccent;
  static const Color Donetask = Color(0xff61E757);
  static TextStyle titleTask = TextStyle(
    color: primryLightColor,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static TextStyle DoneTask = TextStyle(
    color: Donetask,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}
