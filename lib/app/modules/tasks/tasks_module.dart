import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/modules/todo_list_module.dart';
import 'package:review_provider_sqlite/app/modules/tasks/task_create/task_create_controller.dart';
import 'package:review_provider_sqlite/app/modules/tasks/task_create/task_create_page.dart';
import 'package:review_provider_sqlite/app/services/tasks/tasks_service.dart';

import '../../services/tasks/tasks_service_impl.dart';

final class TasksModule extends TodoListModule {

  TasksModule() : super(
    bindings: [
      Provider<TasksService>(
        create: (context) => TasksServiceImpl(
          tasksRepository: context.read(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => TaskCreateController(
          tasksService: context.read(),
        ),
      ),
    ],
    routers: {
      "/tasks/create": (context) => TaskCreatePage(
        controller: context.read(),
      ),
    },
  );
}