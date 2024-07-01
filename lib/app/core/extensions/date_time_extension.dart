extension DateTimeExtension on DateTime {
  
  bool isEqualOnlyDate(DateTime date) {
    return day == date.day && month == date.month && year == date.year;
  }
}