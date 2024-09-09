import 'package:flutter/material.dart';

typedef validationFieled = String? Function(String?)?;

class customTextfiled extends StatelessWidget {
  final String? lable;
  final String? hintText;
  final TextInputType keyboard;
  final TextEditingController controller;
  final bool ObscureText;
  final Widget? suffixIcon;
  final validationFieled validator;
  final TextStyle? textStyle;
  const customTextfiled({
    super.key,
    this.lable,
    required this.keyboard,
    required this.controller,
    this.ObscureText = false,
    this.suffixIcon,
    this.validator,
    this.hintText,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: lable,
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
        disabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary)),
      ),
      keyboardType: keyboard,
      cursorColor: Theme.of(context).colorScheme.primary,
      controller: controller,
      obscureText: ObscureText,
      obscuringCharacter: "*",
      validator: validator,
      style: textStyle,
    );
  }
}
