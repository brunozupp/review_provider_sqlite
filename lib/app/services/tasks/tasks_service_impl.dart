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

}