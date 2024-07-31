import 'package:path/path.dart';
import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';
import 'package:sqflite/sqflite.dart';

class SqliteConnectionFactoryImpl extends SqliteConnectionFactory {

  static const _DATABASE_NAME = "TODO_LIST_PROVIDER";

  static SqliteConnectionFactoryImpl? _instance;

  Database? _db;

  SqliteConnectionFactoryImpl._();

  factory SqliteConnectionFactoryImpl() {

    _instance ??= SqliteConnectionFactoryImpl._();

    return _instance!;
  }

  // Using _lock here because of 'multi thread' of Flutter that is Event Loop
  // So to avoid Event Loop to execute the opening of _db more than one time
  // the lock will literally stop all the other execution from this same method
  // until the first one get completed. That's because I validate if _db == null
  // since after completing the opening in the first execution, ALL the others
  // will already have this value computed.
  @override
  Future<Database> openConnection() async {

    final databasePath = await getDatabasesPath();
    final databasePathFinal = join(databasePath, _DATABASE_NAME);

    if(_db == null) {
      await lock.synchronized(() async {
        _db ??= await openDatabase(
          databasePathFinal,
          version: version,
          onConfigure: onConfigure,
          onCreate: onCreate,
          onUpgrade: onUpgrade,
          onDowngrade: onDowngrade,
        );
      });
    }

    return _db!;
  }
}