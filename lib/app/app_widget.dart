import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/ui/todo_list_ui_config.dart';
import 'package:review_provider_sqlite/app/modules/auth/auth_module.dart';
import 'package:review_provider_sqlite/app/modules/home/home_module.dart';
import 'package:review_provider_sqlite/app/modules/splash/splash_page.dart';

import 'core/database/sqlite_adm_connection.dart';
import 'core/navigator/todo_list_navigator.dart';
import 'modules/tasks/tasks_module.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TodoListNavigator.navigatorKey,
      theme: TodoListUiConfig.theme,
      title: "Todo List",
      routes: {
        "/": (_) => const SplashPage(),
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TasksModule().routers,
      },
    );
  }
}