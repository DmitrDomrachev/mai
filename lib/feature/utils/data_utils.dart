import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:mai/feature/utils/utils.dart';

import '../schedule/models/schedule.dart';

List<List<DateTime>> getWeeks(DateTime startDateTime, DateTime endDateTime) {
  startDateTime =
      startDateTime.subtract(Duration(days: (startDateTime.weekday - 1)));
  endDateTime = endDateTime.add(Duration(days: (7 - endDateTime.weekday) + 1));
  print(endDateTime.difference(startDateTime).inDays);
  List<List<DateTime>> result = [];
  for (int i = 0; i < endDateTime.difference(startDateTime).inDays ~/ 7; i++) {
    result.add([]);
  }

  var index = 0;
  while (startDateTime.isBefore(endDateTime)) {
    result[index ~/ 7].add(startDateTime);
    startDateTime = startDateTime.add(Duration(days: 1));
    index += 1;
  }
  return result;
}

int getWeekIndex(List<List<DateTime>> weeks, DateTime dateTime) {
  int index = 0;
  for (var week in weeks) {
    for (var day in week) {
      if (day.year == dateTime.year &&
          day.month == dateTime.month &&
          day.day == dateTime.day) {
        return index;
      }
    }
    index += 1;
  }

  return index;
}

int getScheduleWeekIndex(List<Week> weeks, DateTime dateTime) {
  int index = 0;
  for (var week in weeks) {
    if (dateTime.isAfter(week.date.startDate) &&
        dateTime.isBefore(week.date.endDate)) {
      return index;
    }
    index += 1;
  }
  return 0;
}

Week? getScheduleWeek(List<Week> weeks, DateTime dateTime) {
  for (var week in weeks) {
    if (dateTime.isAfter(week.date.startDate) &&
        dateTime.isBefore(week.date.endDate)) {
      return week;
    }
  }
  return null;
}

int getScheduleDayIndex(Week week, DateTime dateTime) {
  log('getScheduleDayIndex');
  int index = 0;
  for (var day in week.days) {
    if (isOneDay(dateTime, day.date)) {
      return index;
    }
    index += 1;
  }
  return -1;
}

bool isOneDay(DateTime dateTime1, DateTime dateTime2) {
  return dateTime1.year == dateTime2.year &&
      dateTime1.month == dateTime2.month &&
      dateTime1.day == dateTime2.day;
}

//
void main() {
  final weeks = getWeeks(DateTime(2022, 9, 16), DateTime(2022, 11, 4));
  weeks.forEach((element) {
    print('');
    element.forEach((element1) {
      print(getFormattedDateTime(element1));
    });
  });

  print('index: ${getWeekIndex(weeks, DateTime(2022, 10, 28))}');
  print(weeks.length);
}
