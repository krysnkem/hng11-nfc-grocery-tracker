import 'package:grocey_tag/core/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/providers/expiring_soon_provider.dart';
import 'package:grocey_tag/providers/running_low_provider.dart';
import 'package:grocey_tag/services/storage.service.dart';

class InventoryStateNotifier extends StateNotifier<List<Item>> {
  InventoryStateNotifier(Ref ref)
      : _ref = ref,
        super([]);
  final Ref _ref;

  void getInventoryItemsFromDb() async {
    try {
      state = await StorageService.readAllItems();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(Item item) async {
    try {
      await StorageService.registerItem(item);
      state = [...state, item];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> incrementItemQuantity(Item item, int quantity) async {
    if (item.quantity > quantity) {
      throw 'new quantity has to be larger than old quantity';
    }
    try {
      await StorageService.update(item);
      state = [...state, item.copyWith(quantity: quantity)];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> decrementItemQuantity(Item item, int quantity) async {
    if (item.quantity < quantity) {
      throw 'new quantity has to be less than or equal to than old quantity';
    }
    try {
      if (item.quantity == quantity) {
        StorageService.delete(item);
        state = state.where((element) => element.id != item.id).toList();
        return;
      }
      await StorageService.update(item);
      state = state.where((element) => element.id != item.id).toList();
    } catch (e) {
      rethrow;
    }
  }

  void set(List<Item> items) {
    state = items;
  }

  @override
  set state(List<Item> items) {
    super.state = items;
    _updateDependentProviders();
  }

  void _updateDependentProviders() {
    final nextWeek = DateTime.now().add(const Duration(days: 7));

    final expiringSoonItems =
        state.where((item) => item.expiryDate.isBefore(nextWeek)).toList();
    _ref.read(expiringSoonItemsProvider.notifier).set(expiringSoonItems);

    final runningLowItems = state.where((item) => item.quantity < 7).toList();
    _ref.read(runningLowItemsProvider.notifier).set(runningLowItems);
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryStateNotifier, List<Item>>(
        (ref) => InventoryStateNotifier(ref));
