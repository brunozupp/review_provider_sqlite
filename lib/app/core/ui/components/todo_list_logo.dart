import 'package:flutter/material.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/logo.png",
          height: 200,
        ),
        Text(
          "Todo List",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
