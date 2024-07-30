import 'package:grocey_tag/core/models/item.dart';

class InventoryState {
  const InventoryState._({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  const InventoryState.initial() : this._();

  const InventoryState.loading() : this._(isLoading: true);

  const InventoryState.loaded(List<Item> items) : this._(items: items);

  const InventoryState.error(String error) : this._(error: error);

  InventoryState setloading() {
    return copyWith(isLoading: true);
  }

  InventoryState clearLoading() {
    return copyWith(isLoading: false);
  }

  InventoryState setError({required String message}) {
    return copyWith(error: message);
  }

  InventoryState clearError() {
    return copyWith(error: null);
  }

  final List<Item> items;
  final bool isLoading;
  final String? error;

  InventoryState copyWith({
    List<Item>? items,
    bool? isLoading,
    String? error,
  }) {
    return InventoryState._(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
