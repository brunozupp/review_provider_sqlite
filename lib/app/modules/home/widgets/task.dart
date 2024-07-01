import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/models/task_model.dart';
import 'package:review_provider_sqlite/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {

  final TaskModel taskModel;

  Task({
    super.key,
    required this.taskModel,
  });

  final dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: taskModel.finished,
            onChanged: (value) {
              context.read<HomeController>().checkOrUncheckTask(task: taskModel);
            },
          ),
          title: Text(
            taskModel.description,
            style: TextStyle(
              decoration: taskModel.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            dateFormat.format(taskModel.dateTime),
            style: TextStyle(
              decoration: taskModel.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
