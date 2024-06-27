import 'dart:developer';

import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';
import 'package:review_provider_sqlite/app/core/exceptions/repository_exception.dart';

import './tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {

  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;
  
  @override
  Future<void> save({
    required DateTime date,
    required String description,
  }) async {
    
    try {
      
      final conn = await _sqliteConnectionFactory.openConnection();

      await conn.insert("todo", {
        "id": null,
        "descricao": description,
        "data_hora": date.toIso8601String(),
        "finalizado": 0,
      });

    } catch (e, s) {

      log("Error to create a task", error: e, stackTrace: s);

      throw RepositoryException(message: "Error to create a task");
      
    } finally {
      _sqliteConnectionFactory.closeConnection();
    }
  }
}