import 'package:grocey_tag/core/enums/enum.dart';

class Activity {
  const Activity({
    required this.itemName,
    required this.itemMetric,
    required this.quantity,
    required this.operation,
    required this.date,
  });
  final String itemName;
  final Metric itemMetric;
  // how much of this item was removed or added
  final int quantity;
  // wether the item was removed or added
  final Operation operation;
  final DateTime date;

  Activity copyWith({
    String? itemName,
    Metric? itemMetric,
    int? quantity,
    DateTime? date,
    Operation? operation,
  }) {
    return Activity(
      itemName: itemName ?? this.itemName,
      itemMetric: itemMetric ?? this.itemMetric,
      quantity: quantity ?? this.quantity,
      operation: operation ?? this.operation,
      date: date ?? this.date,
    );
  }

  static Activity generate(
      {required String itemName,
      required Metric itemMetric,
      required int quantity,
      required Operation operation}) {
    return Activity(
      itemName: itemName,
      itemMetric: itemMetric,
      quantity: quantity,
      operation: operation,
      date: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'Quantity(item: ${itemName.toString()}, qty: quantity, operation: ${operation.name}, date: $date)';
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toString(),
      'itemName': itemName,
      'itemMetric': itemMetric,
      'operation': operation.name,
      'quantity': quantity,
    };
  }

  static Activity fromJson(Map<String, dynamic> json) {
    return Activity(
      itemName: json['itemName'],
      itemMetric: json['itemMetric'],
      quantity: json['quantity'] as int,
      operation: Operation.values.byName(json['operation'] as String),
      date: DateTime.parse(json['date'] as String),
    );
  }
}
