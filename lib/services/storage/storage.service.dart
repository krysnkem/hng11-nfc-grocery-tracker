import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocey_tag/core/models/activity.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:grocey_tag/services/storage/app_db.dart';

class FlutterSecureStorageService {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  storeItem({String? key, String? value}) async {
    await storage.write(key: key!, value: value);
  }

  Future<dynamic> readItem({String? key}) async {
    final value = await storage.read(key: key!);
    return value;
  }

  deleteItem({String? key}) async {
    await storage.delete(key: key!);
  }

  deleteAllItems() async {
    await storage.deleteAll();
  }

  Future<dynamic> hasKey({String? key}) async {
    return await storage.containsKey(key: key!);
  }
}

// so our storage would be for items and activity
// for items, we
// should be able to read all items
// want to be able to create new items in the db,
// update an item i.e reduce or increase the qty
// and delete an item

// for recent activity, we just want to
// read all activities
// write an activity

class StorageService {
  static Future<List<Item>> readAllItems() async {
    try {
      final db = await AppDb.getDatabase();
      final rawTableData = await db.query(AppDb.itemsTableName);
      return rawTableData.map((itemMap) => Item.fromJson(itemMap)).toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> registerItem(Item item) async {
    try {
      final db = await AppDb.getDatabase();
      await db.insert(
        AppDb.itemsTableName,
        item.toJson(),
        conflictAlgorithm: AppDb.conflictAlgorithm,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> delete(Item item) async {
    try {
      final db = await AppDb.getDatabase();
      await db.delete(AppDb.itemsTableName,
          where: 'name = ?', whereArgs: [item.name]);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> update(Item item) async {
    try {
      final db = await AppDb.getDatabase();
      await db.update(AppDb.itemsTableName, item.toJson(),
          where: 'name = ?', whereArgs: [item.name]);
    } catch (e) {
      rethrow;
    }
  }

  // we are done with the operations for items

  static Future<List<Activity>> readAllActivity() async {
    try {
      final db = await AppDb.getDatabase();
      final rawTableData = await db.query(AppDb.activitiesTableName);
      return rawTableData
          .map((activityMap) => Activity.fromJson(activityMap))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> registerActivity(Activity activity) async {
    try {
      final db = await AppDb.getDatabase();
      await db.insert(
        AppDb.activitiesTableName,
        activity.toJson(),
        conflictAlgorithm: AppDb.conflictAlgorithm,
      );
    } catch (e) {
      rethrow;
    }
  }
}
