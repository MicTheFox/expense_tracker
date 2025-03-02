import 'package:intl/intl.dart';

class StringFormatters {
  StringFormatters._();

  static NumberFormat currencyFormatter(String currency) =>
      NumberFormat.simpleCurrency(
        locale: 'de_DE',
        name: currency,
        decimalDigits: 2,
      );
}
