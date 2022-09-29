import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group extends Equatable{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String fac;
  @HiveField(3)
  final String level;
  @HiveField(4)
  final int course;

  const Group({
    required this.id,
    required this.name,
    required this.fac,
    required this.level,
    required this.course,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fac': fac,
      'level': level,
      'course': course,
    };
  }

  factory Group.fromJson(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as String,
      name: map['name'] as String,
      fac: map['fac'] as String,
      level: map['level'] as String,
      course: map['course'] as int,
    );
  }

  @override
  List<Object?> get props => [id, name, fac, level, course];
}
