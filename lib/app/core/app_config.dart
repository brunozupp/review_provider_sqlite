import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/firebase_options.dart';

final class AppConfig {

  AppConfig._();

  static Future<void> configure() async {

    WidgetsFlutterBinding.ensureInitialized();

    await _configureFirebase();
  }

  static Future<void> _configureFirebase() async {

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
  }

  static void handleUncaughtError(Object error, StackTrace stackTrace) {
    log("Block error occuried!", error: error, stackTrace: stackTrace);
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  }
}