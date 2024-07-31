import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class AppDb {
  static const String itemsTableName = 'items';
  static const activitiesTableName = 'activities';
  static const conflictAlgorithm = sql.ConflictAlgorithm.ignore;

  static Future<sql.Database> getDatabase() async {
    final databasesPath = await sql.getDatabasesPath();

    final db = await sql.openDatabase(
      path.join(databasesPath, 'grocery.db'),
      version: 1,
      onCreate: (db, newVersion) async {
        for (int version = 0; version < newVersion; version++) {
          _performDbOperationsVersionWise(db, version + 1);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (int version = oldVersion; version < newVersion; version++) {
          _performDbOperationsVersionWise(db, version + 1);
        }
      },
    );
    return db;
  }

  static Future<void> _performDbOperationsVersionWise(
      sql.Database db, int version) async {
    switch (version) {
      case 1:
        await _databaseVersion1(db);
        break;
    }
  }

  static Future<void> _databaseVersion1(sql.Database db) async {
    await db.execute(
        'CREATE TABLE items (name TEXT PRIMARY KEY, quantity INTEGER, metric TEXT, purchaseDate TEXT, expiryDate TEXT, additionalNote TEXT, threshold INTEGER)');
    await db.execute(
        'CREATE TABLE activities ( date TEXT PRIMARY KEY, itemName TEXT, metric TEXT, operation TEXT, quantity INTEGER)');
  }
}
