import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  const TextFieldWidget(
      {super.key,
      required this.label,
      this.suffixIcon,
      this.prefixIcon,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: Icon(suffixIcon),
          border: const OutlineInputBorder()),
    );
  }
}
