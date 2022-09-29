import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mai/feature/setting/data_provider/i_setting_data.dart';
import 'package:mai/feature/setting/data_provider/setting_client.dart';
import 'package:mai/feature/setting/repository/setting_repository.dart';

import '../feature/setting/data_provider/setting_local_storage.dart';
import '../feature/setting/models/group.dart';

Future<void> setupGetIt() async {
  final getIt = GetIt.instance;
  await Hive.initFlutter();

  Hive.registerAdapter(GroupAdapter());

  getIt.registerSingleton<ISettingWebDataSource>(SettingClient());

  getIt.registerSingleton<ISettingLocalDataSource>(
    SettingLocalStorage(
        groupBox: await Hive.openBox<Group>('group_list'),
        settingBox: await Hive.openBox('setting')),
  );

  getIt.registerSingleton<ISettingRepository>(SettingRepository(
      settingDataSource: getIt<ISettingWebDataSource>(),
      settingLocalDataSource: getIt<ISettingLocalDataSource>()));
}
