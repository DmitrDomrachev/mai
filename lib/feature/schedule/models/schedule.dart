class Week {
  int number;
  String date;
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
      date: map['date'] as String,
      days: (map['days'] as List).map((e) => Day.fromMap(e)).toList(),
    );
  }
}

class Day {
  String id;
  String date;
  String name;
  List<Subject> subjects;

  Day({required this.id, required this.date, required this.name, required this.subjects});


  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      id: map['id'] as String,
      date: map['date'] as String,
      name: map['name'] as String,
      subjects: (map['subjects'] as List).map((e) => Subject.fromMap(e)).toList(),
    );
  }
}

class Subject {
  String id;
  String number;
  String name;
  Lector lector;
  Room room;
  String timeStart;
  String timeEnd;
  String type;
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
      lector: Lector.fromMap(map['lector']) ,
      room: Room.fromMap(map['room']) ,
      timeStart: map['timeStart'] as String,
      timeEnd: map['timeEnd'] as String,
      type: map['type'] as String,
      link: map['link'] as String,
    );
  }
}

class Lector {
  String id;
  String name;

  Lector({required this.id, required this.name});

  factory Lector.fromMap(Map<String, dynamic> map) {
    return Lector(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}

class Room {
  String id;
  String name;

  Room({required this.id, required this.name});

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
