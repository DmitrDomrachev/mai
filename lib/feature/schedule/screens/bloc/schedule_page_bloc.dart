import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../../setting/models/group.dart';
import '../../../setting/repository/setting_repository.dart';
import '../../models/schedule.dart';
import '../../repository/schedule_repository.dart';

part 'schedule_page_event.dart';

part 'schedule_page_state.dart';

class SchedulePageBloc extends Bloc<SchedulePageEvent, SchedulePageState> {
  SchedulePageBloc() : super(SchedulePageInitial()) {
    on<SchedulePageRequestData>(_onRequestData);
    on<SchedulePageSelectDay>(_onSelectDay);
  }

  final IScheduleRepository repository = GetIt.I<IScheduleRepository>();
  final ISettingRepository setRepository = GetIt.I<ISettingRepository>();

  FutureOr<void> _onRequestData(
      SchedulePageRequestData event, Emitter<SchedulePageState> emit) async {
    final Group? selectedGroup = setRepository.getSelectedGroup();

    if (selectedGroup == null) {
      emit(SchedulePageNoGroupState());
      return;
    }

    emit(SchedulePageLoadingState(selectedGroup));
    final Schedule schedule = await repository.getSchedule(selectedGroup);
    emit(
      SchedulePageLoadedState(
        schedule: schedule,
        group: selectedGroup,
        selectedDate: DateTime.now(),

      ),
    );
  }

  void _onSelectDay(
      SchedulePageSelectDay event, Emitter<SchedulePageState> emit) {
    if (state is SchedulePageLoadedState) {
      final cState = state as SchedulePageLoadedState;
      emit(cState.copyWith(selectedDate: event.selectedDay));
    }
  }
}
