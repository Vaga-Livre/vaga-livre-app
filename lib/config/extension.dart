import 'package:flutter/material.dart';

extension ThemeGetter on BuildContext {
  ThemeData get themeData => Theme.of(this);
  ColorScheme get colorScheme => this.themeData.colorScheme;
  TextTheme get textTheme => this.themeData.textTheme;
}
