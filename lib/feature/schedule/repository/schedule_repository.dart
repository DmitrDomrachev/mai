import 'package:mai/feature/schedule/data_provider/i_shedule_data.dart';
import 'package:mai/feature/schedule/models/models.dart';
import 'package:mai/feature/setting/models/models.dart';

abstract class IScheduleRepository {
  Future<List<Week>> getSchedule(Group group);
}

class ScheduleRepository extends IScheduleRepository {
  final IScheduleWebDataSource webDataSource;

  ScheduleRepository({required this.webDataSource});

  @override
  Future<List<Week>> getSchedule(Group group) async {
    return await webDataSource.getScheduleByGroup(group);
  }
}
