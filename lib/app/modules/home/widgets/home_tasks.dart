import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';

import 'task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "TODAY'S TASKS",
            style: context.titleStyle,
          ),
          const Column(
            children: [
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
            ],
          )
        ],
      )
    );
  }
}
