import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class UtilComponent {
  static void showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(
        text,
        style: TextStyles.sm,
      ),
      backgroundColor: color,
    ));
  }
}
