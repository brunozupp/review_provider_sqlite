abstract interface class TasksService {

  Future<void> save({
    required DateTime date,
    required String description,
  });
}