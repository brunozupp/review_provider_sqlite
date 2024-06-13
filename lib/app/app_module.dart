import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/app_widget.dart';
import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false, // When run the app it will create the database and all the executions needed
        ),
      ],
      child: const AppWidget(),
    );
  }
}