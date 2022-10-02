import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mai/feature/utils/data_utils.dart';

import '../../../setting/models/group.dart';
import '../../../setting/repository/setting_repository.dart';
import '../../exceptiion/schedule_update_exception.dart';
import '../../models/schedule.dart';
import '../../repository/schedule_repository.dart';

part 'schedule_page_event.dart';

part 'schedule_page_state.dart';

class SchedulePageBloc extends Bloc<SchedulePageEvent, SchedulePageState> {
  SchedulePageBloc() : super(SchedulePageInitial()) {
    on<SchedulePageRequestData>(_onRequestData);
    on<SchedulePageSelectDay>(_onSelectDay);
    on<SchedulePageSwipe>(_onSwipeDay);
  }

  final IScheduleRepository repository = GetIt.I<IScheduleRepository>();
  final ISettingRepository setRepository = GetIt.I<ISettingRepository>();

  Future<void> _onRequestData(
      SchedulePageRequestData event, Emitter<SchedulePageState> emit) async {
    final Group? selectedGroup = setRepository.getSelectedGroup();

    log('_onRequestData');

    if (selectedGroup == null) {
      emit(SchedulePageNoGroupState());
      return;
    }

    emit(SchedulePageLoadingState(selectedGroup));

    Schedule schedule;
    try {
      schedule = await repository.getSchedule(selectedGroup);
    } on ScheduleUpdateException catch (exception) {
      log(exception.toString());
      if (exception.oldSchedule == null) {
        log('emit SchedulePageLoadingErrorState');
        emit(SchedulePageLoadingErrorState(selectedGroup));
        return;
      }
      schedule = exception.oldSchedule!;
      emit(SchedulePageOldScheduleState());
    } catch (exception) {
      log(exception.toString());
      return;
    }

    final dateInMap = schedule
        .getIndexMap()
        .keys
        .firstWhere((element) => isOneDay(element, DateTime.now()));
    final pageIndex = schedule.getIndexMap()[dateInMap] ?? 0;
    final controller = PageController(initialPage: pageIndex);
    emit(
      SchedulePageLoadedState(
        schedule: schedule,
        group: selectedGroup,
        controller: controller,
        pageIndex: pageIndex,
      ),
    );
  }

  void _onSelectDay(
      SchedulePageSelectDay event, Emitter<SchedulePageState> emit) {
    if (state is SchedulePageLoadedState) {
      final cState = state as SchedulePageLoadedState;
      final pageIndex = cState.schedule.getIndexMap()[event.selectedDay];
      if (pageIndex != null) {
        cState.controller.jumpToPage(pageIndex);
        emit(cState.copyWith(pageIndex: pageIndex));
      }
      // emit(cState.copyWith(selectedDate: event.selectedDay));
    }
  }

  void _onSwipeDay(SchedulePageSwipe event, Emitter<SchedulePageState> emit) {
    if (state is SchedulePageLoadedState) {
      final cState = state as SchedulePageLoadedState;
      emit(cState.copyWith(
          pageIndex: event.pageIndex,
          selectedDate: cState.schedule.getDatesMap()[event.pageIndex]));
    }
  }
}
