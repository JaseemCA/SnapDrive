import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String? hintText;
  String? labelText;
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool enabled;

  CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
          labelText: labelText),
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Value is empty';
        } else {
          return null;
        }
      },
    );
  }
}
