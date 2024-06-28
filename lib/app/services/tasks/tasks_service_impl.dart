import 'package:review_provider_sqlite/app/models/task_model.dart';

import '../../models/week_task_model.dart';
import '../../repositories/tasks/tasks_repository.dart';
import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  
  final TasksRepository _tasksRepository;

  TasksServiceImpl({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository;
  
  @override
  Future<void> save({
    required DateTime date,
    required String description,
  }) async {
    await _tasksRepository.save(
      date: date,
      description: description,
    );
  }

  @override
  Future<List<TaskModel>> getToday() async {
    return await _tasksRepository.findByPeriod(
      start: DateTime.now(),
      end: DateTime.now(),
    );
  }

  @override
  Future<List<TaskModel>> getTomorrow() async {

    final tomorrow = DateTime.now().add(const Duration(days: 1));

    return await _tasksRepository.findByPeriod(
      start: tomorrow,
      end: tomorrow,
    );
  }

  @override
  Future<WeekTaskModel> getWeek() async {

    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    
    if(startFilter.weekday != DateTime.monday) {
      startFilter = startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }

    final endFilter = startFilter.add(const Duration(days: 7));

    final tasks = await _tasksRepository.findByPeriod(
      start: startFilter,
      end: endFilter,
    );

    return WeekTaskModel(
      startDate: startFilter,
      endDate: endFilter,
      tasks: tasks,
    );
  }

}