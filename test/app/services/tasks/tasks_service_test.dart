import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:review_provider_sqlite/app/core/exceptions/repository_exception.dart';
import 'package:review_provider_sqlite/app/models/task_model.dart';
import 'package:review_provider_sqlite/app/repositories/tasks/tasks_repository.dart';
import 'package:review_provider_sqlite/app/services/tasks/tasks_service.dart';
import 'package:review_provider_sqlite/app/services/tasks/tasks_service_impl.dart';

/// To have a complete test of this implementation it would be necessary
/// to work with two different approaches: 
/// a mock from the repository to stub Exceptions and see how it`s treated by the Service
/// a 'real' implementation from the repository, but implementing the Simulator database.
/// the simulator database would be to test the Get methods where they have filters inside
/// their queries.
/// Using these two approaches I could have a complete test of my Service. This is possible
/// because I can have the full control of my database, so I don`t depend on API
class TasksRepositoryMock extends Mock implements TasksRepository {}

void main() {

  late final TasksService tasksService;
  late final TasksRepository tasksRepository;

  setUpAll(() {

    tasksRepository = TasksRepositoryMock();

    tasksService = TasksServiceImpl(
      tasksRepository: tasksRepository,
    );
  });

  final current = DateTime.now();
  const description = "TESTE";

  final tasks = [
    TaskModel(id: 1, description: "$description 1", dateTime: current, finished: false),
    TaskModel(id: 2, description: "$description 2", dateTime: current, finished: false),
    TaskModel(id: 3, description: "$description 3", dateTime: current, finished: false),
    TaskModel(id: 4, description: "$description 4", dateTime: current, finished: false),
    TaskModel(id: 5, description: "$description 5", dateTime: current.add(const Duration(days: 1)), finished: false),
    TaskModel(id: 6, description: "$description 6", dateTime: current.add(const Duration(days: 1)), finished: false),
    TaskModel(id: 7, description: "$description 7", dateTime: current.add(const Duration(days: 1)), finished: false),
    TaskModel(id: 8, description: "$description 8", dateTime: current.add(const Duration(days: 3)), finished: false),
    TaskModel(id: 9, description: "$description 9", dateTime: current.add(const Duration(days: 9)), finished: false),
    TaskModel(id: 10, description: "$description 10", dateTime: current.add(const Duration(days: 10)), finished: false),
  ];

  group(
    "Testing method .save",
    () {

      test(
        "Should succeed to call the method save a task",
        () async {

          when(
            () => tasksRepository.save(
              date: current,
              description: description,
            ),
          ).thenAnswer((_) async {});

          await tasksService.save(
            date: current,
            description: description,
          );

          verify(() => tasksRepository.save(
            date: current,
            description: description,
          )).called(1);
        },
      );

      test(
        "Should throw an exception when call by .save",
        () async {

          when(
            () => tasksRepository.save(
              date: current,
              description: description,
            ),
          ).thenThrow(RepositoryException(message: "Error"));

          expect(
            () async => await tasksService.save(
              date: current,
              description: description,
            ), 
            throwsA(isA<RepositoryException>())
          );
        },
      );
    },
  );

  group(
    "Testing method .getToday",
    () {

      test(
        "Should succeed to return value",
        () async {

          when(
            () => tasksRepository.findByPeriod(start: any<DateTime>(named: "start"), end: any<DateTime>(named: "end"),),
          ).thenAnswer((_) async => tasks.where((task) => _isSameDay(task.dateTime,current)).toList());

          final tasksToday = await tasksService.getToday();

          expect(tasksToday.every((task) => _isSameDay(task.dateTime, current)), true);
        },
      );

      test(
        "Should throw an exception",
        () async {
          
          when(
            () => tasksRepository.findByPeriod(start: any<DateTime>(named: "start"), end: any<DateTime>(named: "end"),),
          ).thenThrow(RepositoryException(message: "Error"));

          expect(() async => await tasksService.getToday(), throwsA(isA<RepositoryException>()));
        },
      );
    },
  );

  group(
    "Testing method .getTomorrow",
    () {

      final tomorrow = current.add(const Duration(days: 1));

      test(
        "Should succeed to return value",
        () async {

          when(
            () => tasksRepository.findByPeriod(start: any<DateTime>(named: "start"), end: any<DateTime>(named: "end"),),
          ).thenAnswer((_) async => tasks.where((task) => _isSameDay(task.dateTime,tomorrow)).toList());

          final tasksTomorrow = await tasksService.getTomorrow();

          expect(tasksTomorrow.every((task) => _isSameDay(task.dateTime, tomorrow)), true);
        },
      );

      test(
        "Should throw an exception",
        () async {
          
          when(
            () => tasksRepository.findByPeriod(start: any<DateTime>(named: "start"), end: any<DateTime>(named: "end"),),
          ).thenThrow(RepositoryException(message: "Error"));

          expect(() async => await tasksService.getTomorrow(), throwsA(isA<RepositoryException>()));
        },
      );
    },
  );
}

bool _isSameDay(DateTime d1, DateTime d2) {
  return d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;
}