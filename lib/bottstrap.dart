import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:mai/app/app.dart';
import 'package:mai/service_locator/injectable.dart';

void bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };


  await setupGetIt();

  runZonedGuarded(() => runApp(const App()), (error, stack) {});
}
