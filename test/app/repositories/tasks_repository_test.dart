import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:review_provider_sqlite/app/core/exceptions/repository_exception.dart';
import 'package:review_provider_sqlite/app/repositories/tasks/tasks_repository.dart';

class TasksRepositoryMock extends Mock implements TasksRepository { }

void main() {

  late final TasksRepository tasksRepository;

  final currentDate = DateTime.now();
  const description = "Teste";

  setUpAll(() {
    tasksRepository = TasksRepositoryMock();
  });
  
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

  test(
    "Should throw an exception when executing the method save",
    () {

      when(
        () => tasksRepository.save(
          date: currentDate,
          description: description,
        ),
      ).thenThrow(RepositoryException(message: "Error to save"));

      expect(
        () async => tasksRepository.save(
          date: currentDate,
          description: description,
        ), 
        throwsA(isA<RepositoryException>()));
    },
  );
}