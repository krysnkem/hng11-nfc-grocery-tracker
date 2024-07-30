import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/activity.dart';
import 'package:grocey_tag/core/models/item.dart';

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
  static const _operationDuration = Duration(milliseconds: 500);

  static Future<List<Item>> readAllItems() async {
    try {
      await Future.delayed(_operationDuration);
      final itemNames = [
        'Milk',
        'Sausage',
        'Bread',
        'Fruits',
        'Eggs',
        'Mayonnaise',
        'Pepper',
      ];

      return itemNames
          .map(
            (eachItem) => Item(
                name: eachItem,
                quantity: 10,
                metric: Metric.litre,
                purchaseDate: DateTime.now(),
                expiryDate: DateTime(2024),
                additionalNote: 'This is $eachItem',
                threshold: 7),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> registerItem(Item item) async {
    try {
      await Future.delayed(_operationDuration);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> delete(Item item) async {
    try {
      await Future.delayed(_operationDuration);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> update(Item item) async {
    await Future.delayed(_operationDuration);
  }

  // we are done with the operations for items

  static Future<List<Activity>> readAllActivity() async {
    await Future.delayed(_operationDuration);
    return [
      Activity(
        itemName: 'Mr Beast Choco',
        operation: Operation.add,
        quantity: 5,
        date: DateTime.now().subtract(
          const Duration(days: 2),
        ),
      )
    ];
  }

  static Future<void> registerActivity(Activity activity) async {
    await Future.delayed(_operationDuration);
  }
}
