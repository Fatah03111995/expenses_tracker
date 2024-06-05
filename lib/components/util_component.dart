import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class UtilComponent {
  static void showSnackBar(
      {required BuildContext context,
      required String text,
      required Color color,
      SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      action: action,
      content: Text(
        text,
        style: TextStyles.sm,
      ),
      backgroundColor: color,
    ));
  }

  static void showAlert(
      {required BuildContext context,
      required Text content,
      required List<Widget>? action}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            content: content,
            elevation: 5,
            contentPadding: const EdgeInsets.all(12),
            actions: action,
          );
        });
  }
}
