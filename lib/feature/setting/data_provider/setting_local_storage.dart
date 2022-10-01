import 'package:hive/hive.dart';
import 'package:mai/feature/setting/data_provider/i_setting_data.dart';
import 'package:mai/feature/setting/models/group.dart';

class SettingLocalStorage implements ISettingLocalDataSource {
  final Box settingBox;
  final Box groupBox;

  SettingLocalStorage({required this.groupBox, required this.settingBox});

  @override
  List<Group> getSavedGroups() {
    final List<Group> result = groupBox.values.map((e) => e as Group).toList();
    return result;
  }

  @override
  Future<void> saveGroup(Group group) async {
    if (!groupBox.values.toList().contains(group)) {
      await groupBox.add(group);
    }
  }

  @override
  void selectGroup(Group group) {
    settingBox.put('selected_group', group);
  }

  @override
  Group? getSelectedGroup() {
    final Group? selectedGroup = settingBox.get('selected_group');
    return selectedGroup;
  }

  @override
  void deleteGroup(Group group) {
    var result = groupBox.values.map((e) => (e as Group)).toList();
    result.remove(group);
    if (group == settingBox.get('selected_group')) {
      settingBox.put('selected_group', null);
    }
    groupBox.deleteAll(groupBox.keys);
    groupBox.addAll(result);
  }
}
