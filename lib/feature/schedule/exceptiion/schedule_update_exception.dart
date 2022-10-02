import 'package:mai/feature/schedule/models/models.dart';

class ScheduleUpdateException implements Exception {
  final String message;
  final Schedule? oldSchedule;

  const ScheduleUpdateException(this.message, this.oldSchedule);

  @override
  String toString() {
    return 'ScheduleUpdateException{message: $message, oldSchedule: $oldSchedule}';
  }
}
