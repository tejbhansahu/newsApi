import 'package:flutter/material.dart';

class CustomTextStyle extends TextStyle {
  static titleStyle(
          {Color colors = Colors.black,
          required double size,
          bool isBold = false,
          bool isItalic = false,
          double? letterSpacing}) =>
      TextStyle(
        color: colors,
        fontSize: size,
        fontFamily: "Arial",
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        letterSpacing: letterSpacing ?? 0,
      );
}
