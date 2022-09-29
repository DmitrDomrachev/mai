part of 'setting_page_cubit.dart';

abstract class SettingPageState extends Equatable {
  const SettingPageState();
}

class SettingPageInitial extends SettingPageState {
  final List<Group> groups;
  final Group? selectedGroup;

  const SettingPageInitial({this.groups = const [], this.selectedGroup});

  @override
  List<Object?> get props => [groups, selectedGroup];

  SettingPageInitial copyWith({
    List<Group>? groups,
    Group? selectedGroup,
  }) {
    return SettingPageInitial(
      groups: groups ?? this.groups,
      selectedGroup: selectedGroup ?? this.selectedGroup,
    );
  }
}

class SettingPageAddGroup extends SettingPageState {
  @override
  List<Object?> get props => [];
}
