import 'package:intl/intl.dart';

final weekdayFormatter = DateFormat.EEEE("pt");
final currencyFormatter = NumberFormat.currency(locale: "pt", symbol: r"R$");

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() =>
      replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
