part of 'schedule_page_bloc.dart';

abstract class SchedulePageEvent extends Equatable {
  const SchedulePageEvent();
}

class SchedulePageRequestData extends SchedulePageEvent {
  @override
  List<Object?> get props => [];
}

class SchedulePageSelectDay extends SchedulePageEvent {
  final DateTime selectedDay;

  const SchedulePageSelectDay(this.selectedDay);

  @override
  List<Object?> get props => [selectedDay];
}

class SchedulePageSwipe extends SchedulePageEvent {
  final int pageIndex;

  const SchedulePageSwipe(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}
