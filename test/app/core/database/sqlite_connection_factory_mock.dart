import 'package:review_provider_sqlite/app/core/database/sqlite_connection_factory.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteConnectionFactoryMock extends SqliteConnectionFactory {

  static SqliteConnectionFactoryMock? _instance;

  Database? _db;

  SqliteConnectionFactoryMock._();

  factory SqliteConnectionFactoryMock() {

    _instance ??= SqliteConnectionFactoryMock._();

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

    if(_db == null) {
      await lock.synchronized(() async {
        _db ??= await databaseFactoryFfi.openDatabase(
          inMemoryDatabasePath,
          options: OpenDatabaseOptions(
            version: version,
            onConfigure: onConfigure,
            onCreate: onCreate,
            onUpgrade: onUpgrade,
            onDowngrade: onDowngrade,
          ),
        );

        databaseFactory = databaseFactoryFfi;
      });
    }

    return _db!;
  }
}