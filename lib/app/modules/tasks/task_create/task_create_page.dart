import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';
import 'package:review_provider_sqlite/app/core/ui/components/todo_list_field.dart';
import 'package:review_provider_sqlite/app/modules/tasks/task_create/task_create_controller.dart';

import 'widgets/calendar_button.dart';

class TaskCreatePage extends StatefulWidget {

  final TaskCreateController _controller;

  const TaskCreatePage({
    super.key,
    required TaskCreateController controller,
  }) : _controller = controller;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          )
        ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, 
        label: const Text(
          "Save Task",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.primaryColor,
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Create Task",
                  style: context.titleStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TodoListField(
                label: "",
              ),
              const SizedBox(
                height: 20,
              ),
              CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}
