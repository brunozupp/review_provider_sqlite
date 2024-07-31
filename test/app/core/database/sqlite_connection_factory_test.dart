import 'package:flutter_test/flutter_test.dart';
import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';
import 'package:sqflite/sqflite.dart';

import 'sqlite_connection_factory_mock.dart';

/// Testing a class that is a factory to open a connection with database
/// can be about testing its structure to see if ALL the changes in the
/// database made by the migrations (the case for this project) was succeeded.
/// So, testing the inserting and fetching can be sufficient to this case.
void main() {
  
  late final SqliteConnectionFactory connection;
  late Database db;

  setUpAll(() async {
    connection = SqliteConnectionFactoryMock();

    db = await connection.openConnection();
  });

  tearDownAll(() {
    connection.closeConnection();
  });

  final currentDate = DateTime.now();
  const description = "Teste";

  group(
    "Testing todo table",
    () {

      const todo = "todo";

      test(
        "Should insert inside the table",
        () async {

          await db.insert(todo, {
            "id": null,
            "descricao": description,
            "data_hora": currentDate.toIso8601String(),
            "finalizado": 0,
          });

          final queryResult = await db.rawQuery("SELECT * FROM $todo WHERE id = 1");

          expect(queryResult.length, 1);
        },
      );

      test(
        "Should add 2 more items and get 3 items from table todo",
        () async {

          for (var i = 0; i < 2; i++) {
            await db.insert(todo, {
              "id": null,
              "descricao": "$description ${i + 1}",
              "data_hora": currentDate.add(Duration(days: i + 1)).toIso8601String(),
              "finalizado": 0,
            });
          }

          final queryResult = await db.rawQuery("SELECT * FROM $todo");

          expect(queryResult.length, 3);
        },
      );
    },
  );
}