extension WithTime on DateTime {
  DateTime withTime([int hour = 0, int minute = 0]) =>
      DateTime(year, month, day, hour, minute);
}
