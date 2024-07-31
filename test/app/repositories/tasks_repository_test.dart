import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';
import 'package:review_provider_sqlite/app/repositories/tasks/tasks_repository.dart';
import 'package:review_provider_sqlite/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../core/database/sqlite_connection_factory_mock.dart';

class TasksRepositoryMock extends Mock implements TasksRepository { }

void main() {

  late final TasksRepository tasksRepository;
  late final SqliteConnectionFactory sqlMock;

  final currentDate = DateTime.now();
  const description = "Teste";

  setUpAll(() async {

    sqfliteFfiInit();

    sqlMock = SqliteConnectionFactoryMock();

    tasksRepository = TasksRepositoryImpl(
      sqliteConnectionFactory: sqlMock,
    );
  });

  group(
    "Testing method .save",
    () {
      test(
        "Should succeed to save a new Task without throwing an exception",
        () async {

          when(
            () => tasksRepository.save(
              date: currentDate,
              description: description,
            ),
          ).thenAnswer((_) async {});

          await tasksRepository.save(
            date: currentDate,
            description: description,
          );

          verify(() => tasksRepository.save(
            date: currentDate,
            description: description,
          )).called(1);
        },
      );
    },
  );
}