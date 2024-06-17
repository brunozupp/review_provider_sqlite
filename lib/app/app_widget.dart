import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/modules/splash/splash_page.dart';

import 'core/database/sqlite_adm_connection.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  final sqliteAdm = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addObserver(sqliteAdm);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdm);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo List",
      home: SplashPage(),
    );
  }
}