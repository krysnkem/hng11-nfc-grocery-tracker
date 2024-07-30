import 'package:grocey_tag/core/enums/enum.dart';

class Activity {
  const Activity(
      {required this.itemName,
      required this.quantity,
      required this.operation,
      required this.date,
      required this.metric});
  final String itemName;
  // how much of this item was removed or added
  final int quantity;
  // wether the item was removed or added
  final Operation operation;
  final DateTime date;
  final Metric metric;

  Activity copyWith(
      {String? itemName,
      int? quantity,
      DateTime? date,
      Operation? operation,
      Metric? metric}) {
    return Activity(
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      operation: operation ?? this.operation,
      date: date ?? this.date,
      metric: metric ?? this.metric,
    );
  }

  static Activity generate(
      {required String itemName,
      required int quantity,
      required Operation operation,
      required Metric metric}) {
    return Activity(
      itemName: itemName,
      quantity: quantity,
      operation: operation,
      date: DateTime.now(),
      metric: metric,
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
      'metric': metric.name,
    };
  }

  static Activity fromJson(Map<String, dynamic> json) {
    return Activity(
      itemName: json['itemName'],
      quantity: json['quantity'] as int,
      operation: Operation.values.byName(json['operation'] as String),
      date: DateTime.parse(json['date'] as String),
      metric: Metric.values.byName(json['metric']),
    );
  }
}
