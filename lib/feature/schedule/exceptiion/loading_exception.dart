import 'package:flutter/foundation.dart';

@immutable
class ScheduleLoadingException implements Exception {
  
  final String message;

  const ScheduleLoadingException(this.message);

  @override
  String toString() {
    return 'ScheduleLoadingException{message: $message}';
  }
}
