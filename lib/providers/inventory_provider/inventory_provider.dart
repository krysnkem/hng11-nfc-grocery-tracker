import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/core/enums/enum.dart';
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

  List<Item> get shoppingList => [...runningLowItems, ...expiringItems];

  List<Item> get runningLowItems =>
      state.items.where((item) => item.runningLow).toList();
  List<Item> get expiringItems => state.items
      .where((item) =>
          item.expiryDate.isBefore(DateTime.now().add(const Duration(days: 7))))
      .toList();

  int get totalRunningLowItemsCount => runningLowItems.length;

  int get totalExpiringItemsCount => expiringItems.length;

  final _items = [
    Item(
      name: 'Milk',
      quantity: 2,
      metric: Metric.litre,
      purchaseDate: DateTime(2024, 6, 1),
      expiryDate: DateTime(2024, 6, 30),
      additionalNote: 'Keep refrigerated',
      threshold: 1,
    ),
    Item(
      name: 'Sugar',
      quantity: 5,
      metric: Metric.kg,
      purchaseDate: DateTime(2024, 6, 5),
      expiryDate: DateTime(2024, 6, 30),
      additionalNote: 'Store in a dry place',
      threshold: 2,
    ),
    Item(
      name: 'Garri',
      quantity: 10,
      metric: Metric.kg,
      purchaseDate: DateTime(2024, 6, 10),
      expiryDate: DateTime(2024, 6, 30),
      additionalNote: 'Store in an airtight container',
      threshold: 5,
    ),
    Item(
      name: 'Rice',
      quantity: 20,
      metric: Metric.kg,
      purchaseDate: DateTime(2024, 6, 15),
      expiryDate: DateTime(2024, 6, 30),
      additionalNote: 'Store in a cool, dry place',
      threshold: 10,
    ),
    Item(
      name: 'Beans',
      quantity: 15,
      metric: Metric.kg,
      purchaseDate: DateTime(2024, 6, 20),
      expiryDate: DateTime(2024, 6, 30),
      additionalNote: 'Store in an airtight container',
      threshold: 7,
    ),
  ];

  Future<void> getInventoryItemsFromDb() async {
    try {
      state = const InventoryState.loading();
      _items.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

      state = InventoryState.loaded(_items);
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
      tempList.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

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
      StorageService.update(item);
      tempList.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

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
      items.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

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
