import 'package:flutter/material.dart';
import 'package:kora_app/views/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.onPressedSuffixIcon,
    this.obscureText,
    this.onChanged,
  });

  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final VoidCallback? onPressedSuffixIcon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    obscureText: obscureText ?? false,
    onChanged: onChanged,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: labelText,
      hintText: hintText,
      prefixIcon:
      prefixIcon != null ? Icon(prefixIcon) : null,
      suffixIcon: suffixIcon != null
          ? IconButton(
        onPressed: onPressedSuffixIcon,
        icon: Icon(suffixIcon),
      )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: darkpurple,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: darkpurple),
      ),
      labelStyle: TextStyle(color: darkpurple),
    ),
  );
}
