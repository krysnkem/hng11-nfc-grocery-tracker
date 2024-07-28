import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/item.dart';

class Activity {
  const Activity({
    required this.item,
    required this.quantity,
    required this.operation,
    required this.date,
  });
  final Item item;
  // how much of this item was removed or added
  final int quantity;
  // wether the item was removed or added
  final Operation operation;
  final DateTime date;

  Activity copyWith({
    Item? item,
    int? quantity,
    DateTime? date,
    Operation? operation,
  }) {
    return Activity(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      operation: operation ?? this.operation,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'Quantity(item: ${item.toString()}, qty: quantity, operation: ${operation.name}, date: $date)';
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'quantity': quantity,
      'operation': operation.name,
      'date': date.toString(),
    };
  }

  static Activity fromJson(Map<String, dynamic> json) {
    return Activity(
      item: Item.fromJson(json['item'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      operation: Operation.values.byName(json['operation'] as String),
      date: DateTime.parse(json['date'] as String),
    );
  }
}
