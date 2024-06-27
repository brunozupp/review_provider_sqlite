import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/modules/tasks/task_create/task_create_controller.dart';

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
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
