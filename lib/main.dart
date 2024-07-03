import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/app_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {

  runZonedGuarded(() async {

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // It automatically catches all errors that are thrown within the Flutter framework
    // and sends it to Crashlytics
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      log("FlutterError occuried!", error: errorDetails.exception, stackTrace: errorDetails.stack);
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      log("PlatformDispatcher - Uncaught Asynchronous Error occuried!", error: error, stackTrace: stackTrace);
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
      return true;
    };

    runApp(const AppModule());

  }, (error, stackTrace) {
    log("Block error occuried!", error: error, stackTrace: stackTrace);
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  });

  
}