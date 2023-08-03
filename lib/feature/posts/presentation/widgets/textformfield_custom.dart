import 'package:flutter/material.dart';
import 'package:hackstorage/settings/styles/colors_data.dart';

class CustomPTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validate;
  final TextEditingController controller;
  final bool obscureText;
  const CustomPTextFormField({
    super.key,
    required this.hintText,
    this.validate,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validate,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: ColrsData.greyWhite),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
