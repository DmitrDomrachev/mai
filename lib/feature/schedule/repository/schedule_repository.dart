import 'dart:developer';

import 'package:mai/feature/schedule/data_provider/i_shedule_data.dart';
import 'package:mai/feature/schedule/exceptiion/schedule_update_exception.dart';
import 'package:mai/feature/schedule/models/models.dart';
import 'package:mai/feature/setting/models/models.dart';

import '../../utils/data_utils.dart';

abstract class IScheduleRepository {
  Future<Schedule> getSchedule(Group group);
}

class ScheduleRepository extends IScheduleRepository {
  final IScheduleWebDataSource webDataSource;
  final IScheduleLocalDataSource localDataSource;

  ScheduleRepository(
      {required this.webDataSource, required this.localDataSource});

  @override
  Future<Schedule> getSchedule(Group group) async {

    final Schedule? localSchedule = localDataSource.getScheduleByGroup(group);
    if (localSchedule != null &&
        isOneDay(localSchedule.loadedDate, DateTime.now())) {
      return localSchedule;
    }
    
    try {
      final Schedule webSchedule = Schedule.fromLoadedWeeks(
          await webDataSource.getScheduleByGroup(group));
      localDataSource.saveSchedule(webSchedule, group);
      return webSchedule;
    } catch (exception) {
      throw ScheduleUpdateException(
          exception.toString(), localDataSource.getScheduleByGroup(group));
    }

  }
}
