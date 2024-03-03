import 'package:flutter/material.dart';

typedef validationFieled = String? Function(String?)?;

class customTextfiled extends StatelessWidget {
  String lable;
  TextInputType keyboard;
  TextEditingController controller;
  bool ObscureText;
  Widget? suffixIcon;
  validationFieled validator;
  customTextfiled({
    required this.lable,
    required this.keyboard,
    required this.controller,
    this.ObscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: lable, suffixIcon: suffixIcon),
      keyboardType: keyboard,
      cursorColor: Colors.black,
      controller: controller,
      obscureText: ObscureText,
      obscuringCharacter: "*",
      validator: validator,
    );
  }
}
