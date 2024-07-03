import 'package:review_provider_sqlite/app/core/exceptions/repository_exception.dart';
import 'package:review_provider_sqlite/app/core/extensions/date_time_extension.dart';
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

  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  DateTime? initialDateOfWeek;
  DateTime? selectedDate;

  bool showFinishedTasks = false;

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

  Future<void> findTasks({
    required TaskFilterEnum filter,
  }) async {

    try {

      filterSelected = filter;

      resetStateAndShowLoading();

      notifyListeners();

      List<TaskModel> tasks;

      switch(filter) {
        case TaskFilterEnum.today:
          tasks = await _tasksService.getToday();
          break;
        case TaskFilterEnum.tomorrow:
          tasks = await _tasksService.getTomorrow();
          break;
        case TaskFilterEnum.week:
          final weekTasks = await _tasksService.getWeek();
          initialDateOfWeek = weekTasks.startDate;
          tasks = weekTasks.tasks;
          break;
      }

      allTasks = tasks;
      filteredTasks = tasks;

      if(filter == TaskFilterEnum.week) {

        if(selectedDate != null) {
          filterByDay(selectedDate!);
        } else if(initialDateOfWeek != null) {
          filterByDay(initialDateOfWeek!);
        }
      } else {
        selectedDate = null;
      }

      if(!showFinishedTasks) {
        filteredTasks = filteredTasks.where((task) => !task.finished).toList();
      }

    } on RepositoryException catch(e) {

      setError(e.message);

    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  void filterByDay(DateTime date) {
    selectedDate = date;
    filteredTasks = allTasks
      .where((task) => task.dateTime.isEqualOnlyDate(date))
      .toList();

    notifyListeners();
  }

  Future<void> refreshPage() async {

    await Future.wait([
      findTasks(filter: filterSelected),
      loadTotalTasks(),
    ]);

    notifyListeners();
  }

  Future<void> checkOrUncheckTask({
    required TaskModel task,
  }) async {

    try {

      resetStateAndShowLoading();
      notifyListeners();

      final taskUpdated = task.copyWith(
        finished: !task.finished,
      );

      await _tasksService.checkOrUncheckTask(
        task: taskUpdated,
      );

    } on RepositoryException catch(e) {

      setError(e.message);
    
    } finally {

      hideLoading();
      refreshPage();
    }
  }

  void showOrHideFinishedTasks() {
    showFinishedTasks = !showFinishedTasks;
    refreshPage();
  }
}