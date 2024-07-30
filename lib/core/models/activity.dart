import 'package:grocey_tag/core/enums/enum.dart';

class Activity {
  const Activity({
    required this.itemName,
    required this.quantity,
    required this.operation,
    required this.date,
  });
  final String itemName;
  // how much of this item was removed or added
  final int quantity;
  // wether the item was removed or added
  final Operation operation;
  final DateTime date;

  Activity copyWith({
    String? itemName,
    int? quantity,
    DateTime? date,
    Operation? operation,
  }) {
    return Activity(
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      operation: operation ?? this.operation,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'Quantity(item: ${itemName.toString()}, qty: quantity, operation: ${operation.name}, date: $date)';
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'quantity': quantity,
      'operation': operation.name,
      'date': date.toString(),
    };
  }

  static Activity fromJson(Map<String, dynamic> json) {
    return Activity(
      itemName: json['itemName'],
      quantity: json['quantity'] as int,
      operation: Operation.values.byName(json['operation'] as String),
      date: DateTime.parse(json['date'] as String),
    );
  }
}
