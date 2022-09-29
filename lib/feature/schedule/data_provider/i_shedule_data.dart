import 'package:mai/feature/schedule/models/models.dart';
import 'package:mai/feature/setting/models/models.dart';

abstract class IScheduleWebDataSource {
  Future<List<Week>> getScheduleByGroup(Group group);
}

abstract class IScheduleLocalDataSource extends IScheduleWebDataSource {
  Future<void> saveSchedule(List<Week> schedule);
}
