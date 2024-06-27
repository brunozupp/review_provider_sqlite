import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/modules/todo_list_module.dart';
import 'package:review_provider_sqlite/app/modules/tasks/task_create/task_create_controller.dart';
import 'package:review_provider_sqlite/app/modules/tasks/task_create/task_create_page.dart';

final class TasksModule extends TodoListModule {

  TasksModule() : super(
    bindings: [
      ChangeNotifierProvider(
        create: (context) => TaskCreateController(),
      ),
    ],
    routers: {
      "/task/create": (context) => TaskCreatePage(
        controller: context.read(),
      ),
    },
  );
}