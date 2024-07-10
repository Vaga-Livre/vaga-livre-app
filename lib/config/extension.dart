import 'package:flutter/material.dart';

extension ThemeGetter on BuildContext {
  ThemeData get themeData => Theme.of(this);
  ColorScheme get colorScheme => this.themeData.colorScheme;
  TextTheme get textTheme => this.themeData.textTheme;
}

extension Iterabled<E> on Iterable<E> {
  static Iterable<E> separatedBy<E>(Iterable<E> iterable, {required E Function() separator}) sync* {
    if (iterable.isEmpty) return;
    E item = iterable.first;
    for (var element in iterable.skip(1)) {
      yield item;
      yield separator();
      item = element;
    }
    yield item;
  }
}
