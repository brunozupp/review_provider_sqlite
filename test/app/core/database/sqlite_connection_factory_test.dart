import 'package:flutter_test/flutter_test.dart';
import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';

import 'sqlite_connection_factory_mock.dart';

void main() {
  
  late final SqliteConnectionFactory connection;

  setUpAll(() {
    connection = SqliteConnectionFactoryMock();
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

          final conn = await connection.openConnection();

          await conn.insert(todo, {
            "id": null,
            "descricao": description,
            "data_hora": currentDate.toIso8601String(),
            "finalizado": 0,
          });

          final queryResult = await conn.rawQuery("SELECT * FROM $todo WHERE id = 1");

          expect(queryResult.length, 1);
        },
      );
    },
  );
}