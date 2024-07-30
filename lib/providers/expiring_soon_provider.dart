import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/core/models/item.dart';

class ExpiringSoonItemsStateNotifier extends StateNotifier<List<Item>> {
  ExpiringSoonItemsStateNotifier() : super([]);

  void add(Item item) {
    state = [...state, item];
  }

  void remove(Item item) {
    state = state.where((element) => element.id != item.id).toList();
  }

  void set(List<Item> items) {
    state = items;
  }
}

final expiringSoonItemsProvider =
    StateNotifierProvider<ExpiringSoonItemsStateNotifier, List<Item>>(
        (ref) => ExpiringSoonItemsStateNotifier());