part of 'calendar_cubit.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class CalendarInitial extends CalendarState {
  final DateTime currentDate;
  final DateTime selectedDate;
  final List<List<DateTime>> weeks;
  final PageController controller;

  const CalendarInitial({
    required this.currentDate,
    required this.selectedDate,
    required this.weeks,
    required this.controller,
  });

  @override
  List<Object> get props =>
      [currentDate, selectedDate, weeks, controller];

  CalendarInitial copyWith({
    DateTime? currentDate,
    DateTime? selectedDate,
    List<List<DateTime>>? weeks,
    int? index,
    PageController? controller,
  }) {
    return CalendarInitial(
      currentDate: currentDate ?? this.currentDate,
      selectedDate: selectedDate ?? this.selectedDate,
      weeks: weeks ?? this.weeks,
      controller: controller ?? this.controller,
    );
  }
}
