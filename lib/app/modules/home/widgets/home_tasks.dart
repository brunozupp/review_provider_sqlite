import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';
import 'package:review_provider_sqlite/app/models/task_model.dart';
import 'package:review_provider_sqlite/app/modules/home/home_controller.dart';

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
          Selector<HomeController, String>(
            selector: (_, controller) => "${controller.filterSelected.label}'S TASKS",
            builder: (context, value, child) {
              return Text(
                value,
                style: context.titleStyle,
              );
            },
          ),
          Column(
            children: context
              .select<HomeController, List<TaskModel>>((controller) => controller.filteredTasks)
              .map((value) => Task(
                taskModel: value,
              ))
              .toList(),
          )
        ],
      )
    );
  }
}
