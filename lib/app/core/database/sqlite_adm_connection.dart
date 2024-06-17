import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    // Because this class is a Singleton I don't need to
    // get from the Provider.
    final connection = SqliteConnectionFactory();

    switch(state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        connection.closeConnection();
        break;
    }

    super.didChangeAppLifecycleState(state);
  }
}