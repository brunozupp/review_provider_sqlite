import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/modules/todo_list_module.dart';
import 'package:review_provider_sqlite/app/modules/home/home_controller.dart';
import 'package:review_provider_sqlite/app/modules/home/home_page.dart';

import '../../repositories/tasks/tasks_repository.dart';
import '../../repositories/tasks/tasks_repository_impl.dart';
import '../../services/tasks/tasks_service.dart';
import '../../services/tasks/tasks_service_impl.dart';

final class HomeModule extends TodoListModule {
  
  HomeModule() : super(
    bindings: [
      Provider<TasksRepository>(
        create: (context) => TasksRepositoryImpl(
          sqliteConnectionFactory: context.read(),
        ),
      ),
      Provider<TasksService>(
        create: (context) => TasksServiceImpl(
          tasksRepository: context.read(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeController(
          tasksService: context.read(),
        ),
      ),
    ],
    routers: {
      "/home": (context) => HomePage(
        controller: context.read(),
      ),
    },
  );

}