import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Text label;
  final VoidCallback onPress;
  final Size size;
  final Color color;
  const AuthButton(
      {super.key,
      required this.label,
      required this.onPress,
      required this.size,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(fixedSize: size, backgroundColor: color),
      child: label,
    );
  }
}
