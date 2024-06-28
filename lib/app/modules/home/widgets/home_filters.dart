import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';
import 'package:review_provider_sqlite/app/modules/home/home_controller.dart';
import 'package:review_provider_sqlite/app/modules/home/widgets/todo_card_filter.dart';

import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_model.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FILTERS",
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: "TODAY",
                taskFilter: TaskFilterEnum.today,
                totalTasksModel: TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinished: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>((controller) => controller.filterSelected) == TaskFilterEnum.today,
              ),
              TodoCardFilter(
                label: "TOMMOROW",
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasksModel: TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinished: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>((controller) => controller.filterSelected) == TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                label: "WEEK",
                taskFilter: TaskFilterEnum.week,
                totalTasksModel: TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinished: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>((controller) => controller.filterSelected) == TaskFilterEnum.week,
              ),
            ],
          ),
        )
      ],
    );
  }
}
