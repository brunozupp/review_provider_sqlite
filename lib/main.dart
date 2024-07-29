import 'dart:async';

import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/app_module.dart';
import 'app/core/app_config.dart';

Future<void> main() async {

  runZonedGuarded(() async {

    await AppConfig.configure();

    runApp(const AppModule());

  }, AppConfig.handleUncaughtError);
}