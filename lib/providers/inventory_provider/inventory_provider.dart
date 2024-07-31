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

  List<Item> get shoppingList => <Item>{
        ...runningLowItems,
        ...expiringSoonItems,
        ...expiredItems
      }.toSet().toList();

  List<Item> get runningLowItems =>
      state.items.where((item) => item.runningLow).toList();
  List<Item> get expiringSoonItems =>
      state.items.where((item) => item.expiringSoon).toList();
  List<Item> get expiredItems =>
      state.items.where((item) => item.isExpired).toList();

  int get totalRunningLowItemsCount => runningLowItems.length;

  int get totalExpiringItemsCount => expiringSoonItems.length;

  Future<void> getInventoryItemsFromDb() async {
    try {
      state = const InventoryState.loading();
      final itemList = await StorageService.readAllItems();
      itemList.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));
      state = InventoryState.loaded(itemList);
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

      tempList.add(item);
      tempList.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

      state = InventoryState.loaded(tempList);
      _ref.read(activityProvider.notifier).registerAdd(item);
      await StorageService.registerItem(item);
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
      if (index == -1) {
        tempList.add(item);
        state = InventoryState.loaded(tempList);
        _ref.read(activityProvider.notifier).registerAdd(item);
        return;
      }
      final oldItem = tempList[index];
      if (item.quantity == oldItem.quantity) {
        return;
      }
      tempList[index] = item;
      tempList.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

      state = InventoryState.loaded(tempList);
      if (oldItem.quantity > item.quantity) {
        _ref
            .read(activityProvider.notifier)
            .registerSubract(newItem: item, oldItem: oldItem);
      } else {
        _ref.read(activityProvider.notifier).registerAdd(item);
      }
      await StorageService.update(item);
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
      items.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

      state = InventoryState.loaded(items);
      _ref.read(activityProvider.notifier).registerAdd(item);
      await StorageService.update(item);
    } catch (e) {
      state = state.setError(message: e.toString());
    }
  }

  Future<void> removeItem(Item item) async {
    try {
      final index = state.items.indexWhere(
        (element) => element.name == item.name,
      );

      final items = List<Item>.from(state.items);
      items.removeAt(index);
      items.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

      state = InventoryState.loaded(items);
      _ref.read(activityProvider.notifier).registerDelete(item);
      await StorageService.delete(item);
    } catch (e) {
      state = state.setError(message: e.toString());
    }
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryStateNotifier, InventoryState>(
        (ref) => InventoryStateNotifier(ref));
