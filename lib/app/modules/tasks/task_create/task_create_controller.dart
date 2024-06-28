import 'package:review_provider_sqlite/app/core/exceptions/repository_exception.dart';
import 'package:review_provider_sqlite/app/core/notifier/default_change_notifier.dart';

import '../../../services/tasks/tasks_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  
  final TasksService _tasksService;

  TaskCreateController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  DateTime? _selectedDate;

  set selectedDate(DateTime? value) {
    resetState();
    _selectedDate = value;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save({
    required String description,
  }) async {

    try {

      resetStateAndShowLoading();
      notifyListeners();

      if(_selectedDate != null) {
        await _tasksService.save(
          date: _selectedDate!, 
          description: description,
        );

        success();
      } else {
        setError("Task's date is required");
      }

    } on RepositoryException catch(e) {

      setError(e.message);

    } finally {

      hideLoading();
      notifyListeners();
    }
  }
}