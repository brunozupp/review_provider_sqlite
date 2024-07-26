import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';
import 'package:review_provider_sqlite/app/core/notifier/default_listener_notifier.dart';
import 'package:review_provider_sqlite/app/core/ui/components/todo_list_field.dart';
import 'package:review_provider_sqlite/app/core/ui/messages.dart';
import 'package:review_provider_sqlite/app/modules/tasks/task_create/task_create_controller.dart';
import 'package:validatorless/validatorless.dart';

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

  final _formKey = GlobalKey<FormState>();
  final _descriptionEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DefaultListenerNotifier(
        changeNotifier: widget._controller,
      ).listener(
        context, 
        successCallback: (controller, defaultListener) {
          defaultListener.dispose();
          Navigator.of(context).pop();
        },
        errorCallback: (controller, defaultListener) {
          Messages.of(context).showError(controller.error!);
        },
      );
    });
  }

  @override
  void dispose() {
    _descriptionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
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
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
      
            final isFormValid = _formKey.currentState?.validate() ?? false;
      
            if(isFormValid) {
              widget._controller.save(
                description: _descriptionEC.text,
              );
            }
          }, 
          label: const Text(
            "Save Task",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: context.primaryColor,
        ),
        body: Form(
          key: _formKey,
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
                  controller: _descriptionEC,
                  label: "",
                  validator: Validatorless.required("Description is required"),
                ),
                const SizedBox(
                  height: 20,
                ),
                CalendarButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
