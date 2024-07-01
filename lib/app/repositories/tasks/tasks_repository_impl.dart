import 'dart:developer';

import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';
import 'package:review_provider_sqlite/app/core/exceptions/repository_exception.dart';
import 'package:review_provider_sqlite/app/models/task_model.dart';

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

  @override
  Future<List<TaskModel>> findByPeriod({
    required DateTime start,
    required DateTime end,
  }) async {
    
    try {

      final startFilter = DateTime(start.year,start.month,start.day,0,0,0);
      final endFilter = DateTime(end.year,end.month,end.day,23,59,59);

      final conn = await _sqliteConnectionFactory.openConnection();

      final result = await conn.rawQuery('''
        select * from todo
        where data_hora between ? and ?
        order by data_hora
      ''', [
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ]);

      return result.map<TaskModel>((e) => TaskModel.loadFromDB(e)).toList();

    } catch(e, s) {

      log("Error to retrieve the tasks", error: e, stackTrace: s);

      throw RepositoryException(
        message: "Error to retrieve the tasks",
      );

    } finally {

      _sqliteConnectionFactory.closeConnection();
    }
  }
  
  @override
  Future<void> checkOrUncheckTask({
    required TaskModel task,
  }) async {
    
    try {

      final conn = await _sqliteConnectionFactory.openConnection();

      final finished = task.finished ? 1 : 0;

      await conn.rawUpdate(
        "UPDATE todo SET finalizado = ? WHERE id = ?",
        [finished, task.id],
      );

    } catch(e, s) {

      final action = task.finished ? "check" : "uncheck";

      log("Error to $action the task", error: e, stackTrace: s);

      throw RepositoryException(
        message: "Error to $action the task",
      );

    } finally {

      _sqliteConnectionFactory.closeConnection();
    }
  }
}