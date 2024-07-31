import 'package:review_provider_sqlite/app/core/database/sqlite_migration_factory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

abstract class SqliteConnectionFactory {

  int get version => 1;

  Database? _db;

  // Lock is used when I want to work with 'multi threads'
  // It means that when I work in a application where it has multi thread it will have concurrency inside methods that
  // were called. This cuncurrency can be dangerous because it can open two or more connections with
  // my database, for example. And to be correct it has to be JUST one connection by this instance.
  Lock get lock => Lock();

  Future<Database> openConnection();

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> onCreate(Database db, int version) async {

    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getCreateMigration();

    for(final migration in migrations) {
      migration.create(batch);
    }

    batch.commit();
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {

    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);

    for(final migration in migrations) {
      migration.update(batch);
    }

    batch.commit();
  }

  Future<void> onDowngrade(Database db, int oldVersion, int newVersion) async { }
}