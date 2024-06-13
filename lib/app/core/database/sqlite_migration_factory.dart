
import 'package:review_provider_sqlite/app/core/database/migrations/migration.dart';
import 'package:review_provider_sqlite/app/core/database/migrations/migration_v1.dart';
import 'package:review_provider_sqlite/app/core/database/migrations/migration_v2.dart';
import 'package:review_provider_sqlite/app/core/database/migrations/migration_v3.dart';

class SqliteMigrationFactory {
  
  List<Migration> getCreateMigration() => [
    MigrationV1(),
    MigrationV2(),
    MigrationV3(),
  ];

  List<Migration> getUpgradeMigration(int version) {

    final migrations = <Migration>[];

    // current version = 3
    // version from the app installed = 1
    // This version is the 'oldVersion'
    if(version == 1) {
      migrations.add(MigrationV2());
      migrations.add(MigrationV3());
    }

    // current version = 3
    // version from the app installed = 2
    if(version == 2) {
      migrations.add(MigrationV3());
    }
  
    return migrations;
  }


}