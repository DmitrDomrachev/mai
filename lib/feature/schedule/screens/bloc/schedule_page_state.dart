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

class SchedulePageLoadingState extends SchedulePageState {
  final Group group;

  const SchedulePageLoadingState(this.group);

  @override
  List<Object> get props => [group];
}

class SchedulePageLoadedState extends SchedulePageState {
  final Group group;
  final Schedule schedule;
  final DateTime selectedDate;

  const SchedulePageLoadedState({
    required this.group,
    required this.schedule,
    required this.selectedDate,
  });

  @override
  List<Object> get props => [
        group,
        schedule,
        selectedDate,
      ];

  SchedulePageLoadedState copyWith({
    Group? group,
    Schedule? schedule,
    DateTime? selectedDate,
  }) {
    return SchedulePageLoadedState(
      group: group ?? this.group,
      schedule: schedule ?? this.schedule,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
