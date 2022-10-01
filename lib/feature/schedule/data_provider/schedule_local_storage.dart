import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:mai/feature/schedule/data_provider/i_shedule_data.dart';
import 'package:mai/feature/schedule/models/schedule.dart';
import 'package:mai/feature/setting/models/group.dart';

class ScheduleLocalStorage implements IScheduleLocalDataSource {
  final Box scheduleBox;
  final Box settingBox;

  ScheduleLocalStorage({required this.scheduleBox, required this.settingBox});

  @override
  Schedule? getScheduleByGroup(Group group) {
    return scheduleBox.get(group.id, defaultValue: null);
  }

  @override
  void saveSchedule(Schedule schedule, Group group) {
    scheduleBox.put(group.id, schedule);
  }
}
