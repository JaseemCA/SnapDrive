import 'package:flutter/material.dart';

Widget customElevatedButton({
  required VoidCallback onPressed,
  required String label,
  Color? backgroundColor,
  Color? labelColor,
  double width = 200,
  double height = 5,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: backgroundColor,
      fixedSize: Size(width, height),
    ),
    onPressed: onPressed,
    child: Text(
      label,
      style: TextStyle(color: labelColor),
    ),
  );
}
