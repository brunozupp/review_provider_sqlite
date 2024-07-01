import 'package:review_provider_sqlite/app/core/notifier/default_change_notifier.dart';
import 'package:review_provider_sqlite/app/models/task_filter_enum.dart';
import 'package:review_provider_sqlite/app/models/total_tasks_model.dart';
import 'package:review_provider_sqlite/app/models/week_task_model.dart';
import 'package:review_provider_sqlite/app/services/tasks/tasks_service.dart';

import '../../models/task_model.dart';

class HomeController extends DefaultChangeNotifier {

  final TasksService _tasksService;
  
  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  var filterSelected = TaskFilterEnum.today;

  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;

  Future<void> loadTotalTasks() async {

    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks.first as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks.last as WeekTaskModel;

    todayTotalTasks = _buildTotalTasksModel(todayTasks);
    tomorrowTotalTasks = _buildTotalTasksModel(tomorrowTasks);
    weekTotalTasks = _buildTotalTasksModel(weekTasks.tasks);

    notifyListeners();
  }

  TotalTasksModel _buildTotalTasksModel(List<TaskModel> tasks) {
    return TotalTasksModel(
      totalTasks: tasks.length,
      totalTasksFinished: tasks.where((value) => value.finished).length,
    );
  }
}