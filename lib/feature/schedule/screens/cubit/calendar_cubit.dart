import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai/feature/utils/utils.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({
    required DateTime currentDateTime,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime selectedDateTime,
    required this.onDaySelected,
  }) : super(
          CalendarInitial(
            weeks: getWeeks(startDate, endDate),
            selectedDate: selectedDateTime,
            currentDate: currentDateTime,
            controller: PageController(
              initialPage: getWeekIndex(
                getWeeks(startDate, endDate),
                currentDateTime,
              ),
            ),
          ),
        );
  final Function(DateTime dateTime) onDaySelected;

  void selectDate(DateTime dateTime) {
    log('calendar cubit selectDate');
    if (state is CalendarInitial) {
      final cState = state as CalendarInitial;
      final index = getWeekIndex(cState.weeks, dateTime);
      emit(cState.copyWith(selectedDate: dateTime));
      if (cState.controller.hasClients) {
        cState.controller.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
      onDaySelected(dateTime);
    }
  }

  void jumpToDate(DateTime dateTime) {
    log('calendar cubit selectDate');
    if (state is CalendarInitial) {
      final cState = state as CalendarInitial;
      final index = getWeekIndex(cState.weeks, dateTime);
      emit(cState.copyWith(selectedDate: dateTime));
      if (cState.controller.hasClients) {
        cState.controller.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    }
  }

  @override
  void onChange(Change<CalendarState> change) {
    super.onChange(change);
    // log('onChange CalendarCubit $change');
  }
}
