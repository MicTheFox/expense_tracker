extension DatetimeExtension on DateTime {
  DateTime get dateWithoutTime => DateTime(year, month, day);
}
