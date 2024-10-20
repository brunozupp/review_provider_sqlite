class TaskModel {

  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;

    TaskModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finished
  });


  factory TaskModel.loadFromDB(Map<String, dynamic> map) {
    return TaskModel(
      id: map["id"],
      description: map["descricao"],
      dateTime: DateTime.parse(map["data_hora"]),
      finished: map["finalizado"] == 1,
    );
  }
  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    bool? finished    
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      finished: finished ?? this.finished
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, description: $description, dateTime: $dateTime, finished: $finished)';
  }
}
