import 'package:review_provider_sqlite/app/models/task_model.dart';

import '../../models/week_task_model.dart';

abstract interface class TasksService {

  Future<void> save({
    required DateTime date,
    required String description,
  });

  Future<List<TaskModel>> getToday();

  Future<List<TaskModel>> getTomorrow();
  
  Future<WeekTaskModel> getWeek();
}