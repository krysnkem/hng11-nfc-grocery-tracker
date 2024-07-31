import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:grocey_tag/providers/activity_provider/activity_provider.dart';
import 'package:grocey_tag/services/storage/storage.service.dart';

import 'inventory_state.dart';

class InventoryStateNotifier extends StateNotifier<InventoryState> {
  InventoryStateNotifier(Ref ref)
      : _ref = ref,
        super(const InventoryState.initial()) {
    getInventoryItemsFromDb();
  }
  final Ref _ref;

  int get totalItems => state.items.length;

  int get totalRunningLowItems =>
      state.items.where((item) => item.shouldAddToShoppingList).length;

  int get totalExpiringItems => state.items
      .where((item) =>
          item.expiryDate.isBefore(DateTime.now().add(const Duration(days: 7))))
      .length;

  Future<void> getInventoryItemsFromDb() async {
    try {
      state = const InventoryState.loading();
      state = InventoryState.loaded(await StorageService.readAllItems());
    } catch (e) {
      state = state.setError(message: e.toString());
    }
  }

  ///TODO: REMOVE ASYNC WHEN MIGRATING TO HIVE
  Future<void> register(Item item) async {
    try {
      final tempList = List<Item>.from(state.items);
      if (tempList.contains(item)) {
        state = state.setError(message: 'Item already exists');
        return;
      }
      state = state.setloading();

      await StorageService.registerItem(item);
      tempList.add(item);

      state = InventoryState.loaded(tempList);
      _ref.read(activityProvider.notifier).registerAdd(item);
    } catch (e) {
      state = state.setError(message: e.toString());
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      final index = state.items.indexWhere(
        (element) => element.name == item.name,
      );
      final tempList = List<Item>.from(state.items);
      final oldItem = tempList[index];
      if (item.quantity == oldItem.quantity) {
        return;
      }
      tempList[index] = item;
      StorageService.update(item);
      state = InventoryState.loaded(tempList);
      if (oldItem.quantity > item.quantity) {
        _ref
            .read(activityProvider.notifier)
            .registerSubract(newItem: item, oldItem: oldItem);
      } else {
        _ref.read(activityProvider.notifier).registerAdd(item);
      }
    } catch (e) {
      state = state.setError(message: e.toString());
    }
  }

  Future<void> restockItem(Item item) async {
    try {
      final index = state.items.indexWhere(
        (element) => element.name == item.name,
      );
      final oldItem = state.items[index];
      final newItem = item.copyWith(quantity: item.quantity + oldItem.quantity);
      final items = List<Item>.from(state.items);
      items[index] = newItem;
      StorageService.update(item);

      state = InventoryState.loaded(items);
      _ref.read(activityProvider.notifier).registerAdd(item);
    } catch (e) {
      state = state.setError(message: e.toString());
    }
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryStateNotifier, InventoryState>(
        (ref) => InventoryStateNotifier(ref));
