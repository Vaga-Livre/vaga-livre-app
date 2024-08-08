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

extension TimeOfDayMap on TimeOfDay {
  /// Formats the time of day to a string in the format "HH:mm:00".
  /// As TimeOfDay only tracks the hour and minutes, the seconds are always 00.
  String toISOString() {
    return "$hour:$minute:00";
  }

  // Parses a string in the format "HH:mm:00" into a TimeOfDay.
  // [isoString] should be a valid ISO 8601 time string.
  static TimeOfDay parseIso(String isoString) {
    final parts = isoString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
