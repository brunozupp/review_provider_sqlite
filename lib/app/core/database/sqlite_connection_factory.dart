import 'package:path/path.dart';
import 'package:review_provider_sqlite/app/core/database/sqlite_migration_factory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqliteConnectionFactory {

  static const _VERSION = 1;
  static const _DATABASE_NAME = "TODO_LIST_PROVIDER";

  static SqliteConnectionFactory? _instance;

  Database? _db;

  // Lock is used when I want to work with 'multi threads'
  // It means that when I work in a application where it has multi thread it will have concurrency inside methods that
  // were called. This cuncurrency can be dangerous because it can open two or more connections with
  // my database, for example. And to be correct it has to be JUST one connection by this instance.
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {

    _instance ??= SqliteConnectionFactory._();

    return _instance!;
  }

  // Using _lock here because of 'multi thread' of Flutter that is Event Loop
  // So to avoid Event Loop to execute the opening of _db more than one time
  // the lock will literally stop all the other execution from this same method
  // until the first one get completed. That's because I validate if _db == null
  // since after completing the opening in the first execution, ALL the others
  // will already have this value computed.
  Future<Database> openConnection() async {
    
    final databasePath = await getDatabasesPath();
    final databasePathFinal = join(databasePath, _DATABASE_NAME);

    if(_db == null) {
      await _lock.synchronized(() async {
        _db ??= await openDatabase(
          databasePathFinal,
          version: _VERSION,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onDowngrade: _onDowngrade,
        );
      });
    }

    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> _onCreate(Database db, int version) async {

    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getCreateMigration();

    for(final migration in migrations) {
      migration.create(batch);
    }

    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {

    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);

    for(final migration in migrations) {
      migration.update(batch);
    }

    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async { }
}