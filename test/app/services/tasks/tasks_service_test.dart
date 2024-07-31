import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:review_provider_sqlite/app/repositories/tasks/tasks_repository.dart';
import 'package:review_provider_sqlite/app/services/tasks/tasks_service.dart';
import 'package:review_provider_sqlite/app/services/tasks/tasks_service_impl.dart';

class TasksRepositoryMock extends Mock implements TasksRepository {}

void main() {

  late final TasksService tasksService;
  late final TasksRepository tasksRepository;

  setUpAll(() {

    tasksRepository = TasksRepositoryMock();

    tasksService = TasksServiceImpl(
      tasksRepository: tasksRepository,
    );
  });

  group(
    "Testing method .save",
    () {

      test(
        "Should succeed to save a task",
        () {},
      );
    },
  );
}