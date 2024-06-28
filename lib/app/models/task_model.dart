class TaskModel {

  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;

  TaskModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finished,
  });

  factory TaskModel.loadFromDB(Map<String, dynamic> map) {
    return TaskModel(
      id: map["id"],
      description: map["descricao"],
      dateTime: map["data_hora"],
      finished: map["finalizado"] == 1,
    );
  }
}