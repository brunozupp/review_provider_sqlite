import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';
import 'package:review_provider_sqlite/app/modules/home/home_controller.dart';

import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_model.dart';

class TodoCardFilter extends StatelessWidget {

  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;
  final bool selected;

  const TodoCardFilter({
    super.key,
    required this.label, 
    required this.taskFilter, 
    this.totalTasksModel,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeController>().findTasks(filter: taskFilter);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
          maxHeight: 120,
          maxWidth: 180,
        ),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: const EdgeInsets.only(
          right: 10,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getTotalTasksLabel(),
              style: context.titleStyle.copyWith(
                fontSize: 10,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
            const Spacer(),
            Text(
              label,
              style: context.titleStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: _getPercentageFinishedTasks(),
              ),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  backgroundColor: selected ? context.primaryColorLight : Colors.grey.shade300,
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    selected ? Colors.white : context.primaryColor
                  ),
                );
              },
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  String _getTotalTasksLabel() {

    var totalOfTasks = 0;

    if(totalTasksModel != null) {
      totalOfTasks = totalTasksModel!.totalTasks;
    }
    
    var label = "$totalOfTasks TASKS";

    if(totalOfTasks > 0) {

      final finishedTasks = totalTasksModel!.totalTasksFinished;

      label += " ($totalOfTasks/$finishedTasks)";
    }

    return label;
  }

  double _getPercentageFinishedTasks() {

    final total = totalTasksModel?.totalTasks ?? 0.1;
    final totalFinished = totalTasksModel?.totalTasksFinished ?? 0.1;

    if(total == 0) {
      return 0;
    }

    final percentage = (totalFinished * 100) / total;

    return percentage / 100;
  }
}
