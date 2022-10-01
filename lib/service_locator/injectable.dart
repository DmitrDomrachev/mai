import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mai/feature/schedule/data_provider/i_shedule_data.dart';
import 'package:mai/feature/schedule/data_provider/schedule_client.dart';
import 'package:mai/feature/schedule/data_provider/schedule_local_storage.dart';
import 'package:mai/feature/schedule/models/schedule.dart';
import 'package:mai/feature/schedule/repository/schedule_repository.dart';
import 'package:mai/feature/setting/data_provider/i_setting_data.dart';
import 'package:mai/feature/setting/data_provider/setting_client.dart';
import 'package:mai/feature/setting/repository/setting_repository.dart';

import '../feature/setting/data_provider/setting_local_storage.dart';
import '../feature/setting/models/group.dart';

Future<void> setupGetIt() async {
  final getIt = GetIt.instance;
  await Hive.initFlutter();

  Hive.registerAdapter(GroupAdapter());

  Hive.registerAdapter(RoomAdapter());
  Hive.registerAdapter(LectorAdapter());
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(DayAdapter());
  Hive.registerAdapter(WeekDateAdapter());
  Hive.registerAdapter(WeekAdapter());
  Hive.registerAdapter(ScheduleAdapter());

  getIt.registerSingleton<ISettingWebDataSource>(SettingClient());
  final settingBox = await Hive.openBox('setting');
  getIt.registerSingleton<ISettingLocalDataSource>(
    SettingLocalStorage(
        groupBox: await Hive.openBox<Group>('group_list'),
        settingBox: settingBox),
  );

  getIt.registerSingleton<ISettingRepository>(
    SettingRepository(
      settingDataSource: getIt<ISettingWebDataSource>(),
      settingLocalDataSource: getIt<ISettingLocalDataSource>(),
    ),
  );

  getIt.registerSingleton<IScheduleWebDataSource>(
    ScheduleClient(),
  );

  getIt.registerSingleton<IScheduleLocalDataSource>(
    ScheduleLocalStorage(
      scheduleBox: await Hive.openBox('schedule'),
      settingBox: settingBox,
    ),
  );

  getIt.registerSingleton<IScheduleRepository>(
    ScheduleRepository(
      webDataSource: getIt<IScheduleWebDataSource>(),
      localDataSource: getIt<IScheduleLocalDataSource>(),
    ),
  );
}
