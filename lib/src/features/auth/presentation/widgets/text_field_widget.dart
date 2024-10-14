import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final IconButton? suffixIcon;
  final IconButton? prefixIcon;
  final BorderRadius? borderRadius;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool? obsecuredText;
  const TextFieldWidget(
      {super.key,
      required this.label,
      this.suffixIcon,
      this.prefixIcon,
      required this.controller,
      this.borderRadius,
      this.obsecuredText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,

      // obscureText: obsecuredText!,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          hintText: label,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: borderRadius!)),
    );
  }
}
