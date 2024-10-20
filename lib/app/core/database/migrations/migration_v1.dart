import 'package:review_provider_sqlite/app/core/database/migrations/migration.dart';
import 'package:sqflite/sqflite.dart';

final class MigrationV1 implements Migration {
  
  @override
  void create(Batch batch) {
    
    batch.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao VARCHAR(500) NOT NULL,
        data_hora DATETIME,
        finalizado INTEGER
      )

    ''');
  }

  @override
  void update(Batch batch) {}

}