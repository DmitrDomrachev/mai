import 'package:mai/feature/setting/data_provider/i_setting_data.dart';
import 'package:mai/feature/setting/models/models.dart';

abstract class ISettingRepository {
  Future<List<Group>> getGroupByName(String name);

  void saveGroup(Group group);

  List<Group> getSavedGroups();

  void selectGroup(Group group);

  Group? getSelectedGroup();

  void deleteGroup(Group group);
}

class SettingRepository extends ISettingRepository {
  final ISettingWebDataSource _webDataSource;
  final ISettingLocalDataSource _localDataSource;

  SettingRepository(
      {required ISettingWebDataSource settingDataSource,
      required ISettingLocalDataSource settingLocalDataSource})
      : _webDataSource = settingDataSource,
        _localDataSource = settingLocalDataSource;

  @override
  Future<List<Group>> getGroupByName(String name) async {
    return await _webDataSource.getGroupByName(name);
  }

  @override
  List<Group> getSavedGroups() {
    return _localDataSource.getSavedGroups();
  }

  @override
  Group? getSelectedGroup() {
    return _localDataSource.getSelectedGroup();
  }

  @override
  void selectGroup(Group group) {
    _localDataSource.selectGroup(group);
  }

  @override
  void saveGroup(Group group) {
    _localDataSource.saveGroup(group);
    _localDataSource.selectGroup(group);
  }

  @override
  void deleteGroup(Group group) {
    _localDataSource.deleteGroup(group);
  }
}
