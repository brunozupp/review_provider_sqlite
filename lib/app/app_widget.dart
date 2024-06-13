import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo List",
      home: SplashPage(),
    );
  }
}