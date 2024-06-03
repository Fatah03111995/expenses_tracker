import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController textController;
  final String label;
  final String? hint;
  final String? prefixText;
  final String? initialValue;
  final TextInputType? keyboardType;
  const InputText(
      {super.key,
      required this.textController,
      required this.label,
      this.hint,
      this.prefixText,
      this.initialValue,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    const BorderSide borderSide = BorderSide(width: 3);

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextFormField(
        controller: textController,
        style: TextStyles.s,
        initialValue: initialValue,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyles.s.copyWith(color: Colors.white),
          label: Text(label,
              style: TextStyles.sm.copyWith(color: Colors.deepPurple)),
          errorStyle: TextStyles.s.copyWith(color: Colors.red),
          prefixText: prefixText,
          border: const UnderlineInputBorder(borderSide: borderSide),
          errorBorder: UnderlineInputBorder(
              borderSide: borderSide.copyWith(color: Colors.red)),
          focusedBorder: UnderlineInputBorder(
              borderSide: borderSide.copyWith(color: Colors.deepPurple)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required !';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
