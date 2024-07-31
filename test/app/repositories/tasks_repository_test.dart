import 'package:flutter_test/flutter_test.dart';
import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';
import 'package:review_provider_sqlite/app/repositories/tasks/tasks_repository.dart';
import 'package:review_provider_sqlite/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../core/database/sqlite_connection_factory_simulator.dart';

/// When working with sqflite and my repository uses a instance of
/// a factory class that is responsible by returning a database
/// to do all the queries inside the repository`s methods, one
/// solution of test is use the Simulator class created to
/// `fake` a persistence of data.
void main() {

  late final TasksRepository tasksRepository;
  late final SqliteConnectionFactory sqliteConnectionFactory;

  final currentDate = DateTime.now();
  const description = "Teste";

  setUpAll(() async {

    sqfliteFfiInit();

    sqliteConnectionFactory = SqliteConnectionFactorySimulator();

    tasksRepository = TasksRepositoryImpl(
      sqliteConnectionFactory: sqliteConnectionFactory,
    );
  });

  tearDown(() async {
    await tasksRepository.deleteAll();
  });

  tearDownAll(() {
    sqliteConnectionFactory.closeConnection();
  });

  group(
    "Testing method .save",
    () {
      test(
        "Should succeed to save a new Task without throwing an exception",
        () async {

          final newDescription = "$description + ${currentDate.toIso8601String()}";

          await tasksRepository.save(
            date: currentDate,
            description: newDescription,
          );

          final tasks = await tasksRepository.findByPeriod(
            start: currentDate,
            end: currentDate,
          );

          expect(tasks.any((task) => task.description == newDescription), true);
        },
      );
    },
  );

  group(
    "Testing method .findByPeriod",
    () {

      test(
        "Should find all the tasks in the specific range",
        () async {

          for (var i = 1; i <= 5; i++) {
            await tasksRepository.save(
              date: currentDate.add(Duration(days: i)),
              description: "$description + $i",
            );
          }

          final tasks = await tasksRepository.findByPeriod(
            start: currentDate,
            end: currentDate.add(const Duration(days: 3)),
          );

          expect(tasks.length, 3);
        },
      );
    },
  );

  group(
    "Testing method .checkOrUncheckTask",
    () {
      
      test(
        "Should change the flag to true after calling the method",
        () async {

          await tasksRepository.save(
            date: currentDate,
            description: description,
          );

          final tasks = await tasksRepository.findByPeriod(
            start: currentDate,
            end: currentDate,
          );

          final task = tasks.first.copyWith(
            finished: !tasks.first.finished,
          );

          await tasksRepository.checkOrUncheckTask(task: task);

          final tasksAfterCheckTask = await tasksRepository.findByPeriod(
            start: currentDate,
            end: currentDate,
          );

          expect(tasksAfterCheckTask.first.finished, true);
        },
      );
    },
  );

  group(
    "Testing method .deleteAll",
    () {

      test(
        "Should delete all the tasks",
        () async {

          const daysAhead = 6;

          for (var i = 0; i < daysAhead; i++) {
            await tasksRepository.save(
              date: currentDate.add(Duration(days: i)),
              description: "$description + $i",
            );
          }

          final tasks = await tasksRepository.findByPeriod(
            start: currentDate,
            end: currentDate.add(const Duration(days: daysAhead)),
          );

          expect(tasks.isEmpty, false);

          await tasksRepository.deleteAll();

          final tasksAfterDeleteAll = await tasksRepository.findByPeriod(
            start: currentDate,
            end: currentDate.add(const Duration(days: daysAhead)),
          );

          expect(tasksAfterDeleteAll.isEmpty, true);
        },
      );
    },
  );

  group(
    "Testing method .deleteById",
    () {

      test(
        "Should delete all the tasks",
        () async {

          const daysAhead = 6;

          for (var i = 0; i < daysAhead; i++) {
            await tasksRepository.save(
              date: currentDate.add(Duration(days: i)),
              description: "$description + $i",
            );
          }

          final tasks = await tasksRepository.findByPeriod(
            start: currentDate,
            end: currentDate.add(const Duration(days: daysAhead)),
          );

          final tasksLength = tasks.length;

          await tasksRepository.deleteById(
            taskId: tasks.first.id,
          );

          final tasksAfterDeleteById = await tasksRepository.findByPeriod(
            start: currentDate,
            end: currentDate.add(const Duration(days: daysAhead)),
          );

          final tasksLengthAfterDeleteById = tasksAfterDeleteById.length;

          expect(tasksLengthAfterDeleteById, tasksLength - 1);
        },
      );
    },
  );
}