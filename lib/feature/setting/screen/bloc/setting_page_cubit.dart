import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mai/feature/setting/repository/setting_repository.dart';

import '../../models/group.dart';

part 'setting_page_state.dart';

class SettingPageCubit extends Cubit<SettingPageState> {
  SettingPageCubit() : super(const SettingPageInitial());

  final ISettingRepository repository = GetIt.I<ISettingRepository>();

  void init() async {
    if (state is SettingPageInitial) {
      final cState = state as SettingPageInitial;
      emit(
        cState.copyWith(
          groups: repository.getSavedGroups(),
          selectedGroup: repository.getSelectedGroup(),
        ),
      );
    } else {
      emit(const SettingPageInitial());
    }
  }

  void selectGroup(Group group) {
    repository.selectGroup(group);
    emit(
      (state as SettingPageInitial).copyWith(
        groups: repository.getSavedGroups(),
        selectedGroup: repository.getSelectedGroup(),
      ),
    );
  }

void deleteGroup(Group group) {
    repository.deleteGroup(group);
    emit(
      (state as SettingPageInitial).copyWith(
        groups: repository.getSavedGroups(),
        selectedGroup: repository.getSelectedGroup(),
      ),
    );
  }

  void addGroup(){
    emit(SettingPageAddGroup());
  }

  @override
  void onChange(Change<SettingPageState> change) {
    super.onChange(change);
  }
}
