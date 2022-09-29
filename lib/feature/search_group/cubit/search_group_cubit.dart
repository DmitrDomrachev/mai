

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../setting/models/group.dart';
import '../../setting/repository/setting_repository.dart';

part 'search_group_state.dart';

class SearchGroupCubit extends Cubit<SearchGroupState> {
  SearchGroupCubit() : super(const SearchGroupInitial());

  final ISettingRepository repo = GetIt.I<ISettingRepository>();

  Future<void> inputSearchName(String text) async {
    if (state is SearchGroupInitial) {
      final cState = state as SearchGroupInitial;
      emit(
        (cState).copyWith(
          searchResult: await repo.getGroupByName(text),
        ),
      );
    }
  }

  void chooseGroup(int index) {
    if (state is SearchGroupInitial) {
      final cState = state as SearchGroupInitial;
      repo.saveGroup(cState.searchResult[index]);
    }
    emit(SearchGroupDone());
  }

  void getGroupsCount() {
    if (state is SearchGroupInitial) {
      final cState = state as SearchGroupInitial;
      final groups = repo.getSavedGroups();
      emit(cState.copyWith(searchText: groups.length.toString()));
    }
  }
}
