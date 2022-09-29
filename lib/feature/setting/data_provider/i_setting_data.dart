import 'package:mai/feature/setting/models/models.dart';

abstract class ISettingWebDataSource {
  Future<List<Group>> getGroupByName(String name);
}

abstract class ISettingLocalDataSource {
  void saveGroup(Group group);

  List<Group> getSavedGroups();

  void selectGroup(Group group);

  Group? getSelectedGroup();

  void deleteGroup(Group group);
}
