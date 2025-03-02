import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static NumberFormat currencyFormatter(String currency) =>
      NumberFormat.simpleCurrency(
        locale: 'de_DE',
        name: currency,
        decimalDigits: 2,
      );

  static DateFormat get dateFormatter => DateFormat.yMMMd();
}
