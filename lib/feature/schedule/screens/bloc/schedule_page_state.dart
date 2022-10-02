part of 'schedule_page_bloc.dart';

abstract class SchedulePageState extends Equatable {
  const SchedulePageState();
}

class SchedulePageInitial extends SchedulePageState {
  @override
  List<Object> get props => [];
}

class SchedulePageNoGroupState extends SchedulePageState {
  @override
  List<Object> get props => [];
}

class SchedulePageOldScheduleState extends SchedulePageState {
  @override
  List<Object> get props => [];
}


class SchedulePageLoadingState extends SchedulePageState {
  final Group group;

  const SchedulePageLoadingState(this.group);

  @override
  List<Object> get props => [group];
}

class SchedulePageLoadingErrorState extends SchedulePageState {
  final Group group;

  const SchedulePageLoadingErrorState(this.group);

  @override
  List<Object> get props => [group];
}

class SchedulePageLoadedState extends SchedulePageState {
  final Group group;
  final Schedule schedule;
  // final DateTime selectedDate;
  final PageController controller;
  final int pageIndex;

  // final Map<int, DateTime> datesMap;

  const SchedulePageLoadedState({
    required this.group,
    required this.schedule,
    // required this.selectedDate,
    required this.controller,
    required this.pageIndex,
    // required this.datesMap
  });

  @override
  List<Object> get props =>
      [
        group,
        schedule,
        controller,
        pageIndex,
      ];

  SchedulePageLoadedState copyWith({
    Group? group,
    Schedule? schedule,
    DateTime? selectedDate,
    PageController? controller,
    int? pageIndex,
  }) {
    return SchedulePageLoadedState(
      group: group ?? this.group,
      schedule: schedule ?? this.schedule,
      // selectedDate: selectedDate ?? this.selectedDate,
      controller: controller ?? this.controller,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
