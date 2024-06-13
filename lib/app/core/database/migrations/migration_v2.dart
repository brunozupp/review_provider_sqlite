import 'package:review_provider_sqlite/app/core/database/migrations/migration.dart';
import 'package:sqflite/sqflite.dart';

final class MigrationV2 implements Migration {
  
  @override
  void create(Batch batch) {
    
    batch.execute('''
      CREATE TABLE teste(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao VARCHAR(100)
      )
    ''');
  }

  @override
  void update(Batch batch) {

    batch.execute('''
      CREATE TABLE teste(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao VARCHAR(100)
      )
    ''');
  }

}