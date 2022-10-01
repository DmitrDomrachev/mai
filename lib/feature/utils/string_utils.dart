import 'package:intl/intl.dart';

String getFormattedDateTime(
  DateTime dateTime, {
  day = true,
  month = true,
  year = true,
}) {
  var pattern = '';
  if (day) {
    pattern += 'dd';
  }
  if (month) {
    pattern += '.MM';
  }
  if (year) {
    pattern += '.y';
  }
  return DateFormat(pattern).format(dateTime);
}

String getWeekdayName(DateTime dateTime) {
  switch (dateTime.weekday){
    case 1:
      return 'Пн';
    case 2:
      return 'Вт';
    case 3:
      return 'Ср';
    case 4:
      return 'Чт';
    case 5:
      return 'Пт';
    case 6:
      return 'Сб';
    case 7:
      return 'Вс';
    case 8:
      return 'Авг';
    case 9:
      return 'Сен';
    case 10:
      return 'Окт';
    case 11:
      return 'Ноя';
    case 12:
      return 'Дек';
  }
  return '';
}


String getMonthName(DateTime dateTime) {
  switch (dateTime.month){
    case 1:
      return 'Января';
    case 2:
      return 'Февраля';
    case 3:
      return 'Марта';
    case 4:
      return 'Апреля';
    case 5:
      return 'Мая';
    case 6:
      return 'Июня';
    case 7:
      return 'Июля';
    case 8:
      return 'Августа';
    case 9:
      return 'Сентября';
    case 10:
      return 'Октября';
    case 11:
      return 'Ноября';
    case 12:
      return 'Декабря';
  }
  return '';
}
