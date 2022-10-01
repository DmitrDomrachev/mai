import 'package:mai/feature/schedule/models/models.dart';
import 'package:mai/feature/setting/models/models.dart';

abstract class IScheduleWebDataSource {
  Future<List<Week>> getScheduleByGroup(Group group);
}

abstract class IScheduleLocalDataSource {
  void saveSchedule(Schedule schedule, Group group);

  Schedule? getScheduleByGroup(Group group);
}
