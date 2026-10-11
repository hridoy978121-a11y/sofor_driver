import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.text, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
      onPressed: onTap,
      child: Text(text),
    );
  }
}