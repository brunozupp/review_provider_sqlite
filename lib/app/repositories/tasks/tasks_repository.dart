import 'package:review_provider_sqlite/app/models/task_model.dart';

abstract interface class TasksRepository {

  Future<void> save({
    required DateTime date,
    required String description,
  });

  Future<List<TaskModel>> findByPeriod({
    required DateTime start,
    required DateTime end,
  });

  Future<void> checkOrUncheckTask({
    required TaskModel task,
  });

  Future<void> deleteAll();

  Future<void> deleteById({
    required int taskId,
  });
}