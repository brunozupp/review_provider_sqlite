import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/ui/components/todo_list_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TodoListLogo(),
      ),
    );
  }
}
