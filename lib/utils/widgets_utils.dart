import 'package:flutter/material.dart';

extension EdgeInsetsExtension on EdgeInsets {
  static EdgeInsets maxWidth({
    required double width,
    required double maxWidth,
  }) =>
      EdgeInsets.symmetric(
        horizontal: (width - maxWidth).clamp(0, double.maxFinite) / 2,
      );
}
