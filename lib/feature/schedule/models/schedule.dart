
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../utils/data_utils.dart';

part 'schedule.g.dart';

@HiveType(typeId: 8)
class Schedule {
  @HiveField(0)
  final DateTime loadedDate;
  @HiveField(1)
  final List<Week> _weeks;
  @HiveField(2)
  final DateTime startDate;
  @HiveField(3)
  final DateTime endTime;

  Schedule(
    this.loadedDate,
    this._weeks,
    this.startDate,
    this.endTime,
  );

  factory Schedule.fromLoadedWeeks(List<Week> weeks) {
    final DateTime startDate = weeks.first.date.startDate;
    final DateTime endDate = weeks.last.date.endDate;
    final DateTime loadedDate = DateTime.now();
    return Schedule(loadedDate, weeks, startDate, endDate);
  }

  Day? getDaySchedule(DateTime dateTime) {
    for (var week in _weeks) {
      if ((week.date.startDate.isAtSameMomentAs(dateTime)) ||
          (week.date.endDate.isAtSameMomentAs(dateTime)) ||
          (week.date.startDate.isBefore(dateTime) &&
              week.date.endDate.isAfter(dateTime))) {
        for (var day in week.days) {
          if (isOneDay(day.date, dateTime)) {
            return day;
          }
        }
      }
    }
    return null;
  }

}

@HiveType(typeId: 7)
class Week {
  @HiveField(0)
  int number;
  @HiveField(1)
  WeekDate date;
  @HiveField(2)
  List<Day> days;

  Week({required this.number, required this.date, required this.days});

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'date': date,
      'days': days,
    };
  }

  factory Week.fromJson(Map<String, dynamic> map) {
    return Week(
      number: map['number'] as int,
      date: WeekDate.fromString(map['date']),
      days: (map['days'] as List).map((e) => Day.fromMap(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'Week{number: $number, date: ${date.startDate.day} - ${date.endDate.day}, days length: ${days.length}';
  }
}

@HiveType(typeId: 6)
class WeekDate {
  @HiveField(0)
  DateTime startDate;
  @HiveField(1)
  DateTime endDate;

  WeekDate({
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory WeekDate.fromString(String dates) {
    //29.08.2022 - 04.09.2022
    final datesList = dates.split(' - ');
    final format = DateFormat('dd.MM.yyyy');
    return WeekDate(
      startDate: format.parse(datesList[0]),
      endDate: format.parse(datesList[1]),
    );
  }

  @override
  String toString() {
    return 'WeekDate{startDate: ${startDate.day}.${startDate.month}, endDate: ${endDate.day}.${endDate.month}}';
  }
}

@HiveType(typeId: 5)
class Day {
  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  String name;
  @HiveField(3)
  List<Subject> subjects;

  Day(
      {required this.id,
      required this.date,
      required this.name,
      required this.subjects});

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      id: map['id'] as String,
      date: DateFormat('dd.MM.yyyy').parse(map['date']),
      name: map['name'] as String,
      subjects:
          (map['subjects'] as List).map((e) => Subject.fromMap(e)).toList(),
    );
  }
}

@HiveType(typeId: 4)
class Subject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String number;
  @HiveField(2)
  String name;
  @HiveField(3)
  Lector lector;
  @HiveField(4)
  Room room;
  @HiveField(5)
  String timeStart;
  @HiveField(6)
  String timeEnd;
  @HiveField(7)
  String type;
  @HiveField(8)
  String link;

  Subject(
      {required this.id,
      required this.number,
      required this.name,
      required this.lector,
      required this.room,
      required this.timeStart,
      required this.timeEnd,
      required this.type,
      required this.link});

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'] as String,
      number: map['number'] as String,
      name: map['name'] as String,
      lector: Lector.fromMap(map['lector']),
      room: Room.fromMap(map['room']),
      timeStart: map['timeStart'] as String,
      timeEnd: map['timeEnd'] as String,
      type: map['type'] as String,
      link: map['link'] as String,
    );
  }
}

@HiveType(typeId: 3)
class Lector {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  Lector({required this.id, required this.name});

  factory Lector.fromMap(Map<String, dynamic> map) {
    return Lector(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}

@HiveType(typeId: 2)
class Room {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  Room({required this.id, required this.name});

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
