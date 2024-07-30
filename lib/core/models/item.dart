import 'package:equatable/equatable.dart';
import 'package:grocey_tag/core/enums/enum.dart';

class Item extends Equatable {
  const Item({
    required this.name,
    required this.quantity,
    required this.metric,
    required this.purchaseDate,
    required this.expiryDate,
    required this.additionalNote,
    required this.threshold,
  });

  final String name;
  final int quantity;
  final Metric metric;
  final DateTime purchaseDate;
  final DateTime expiryDate;
  final String additionalNote;
  final int threshold;

  // Copy method to create a new instance with modified fields
  Item copyWith({
    String? name,
    int? quantity,
    Metric? metric,
    DateTime? purchaseDate,
    DateTime? expiryDate,
    String? additionalNote,
    int? threshold,
  }) {
    return Item(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      metric: metric ?? this.metric,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expiryDate: expiryDate ?? this.expiryDate,
      additionalNote: additionalNote ?? this.additionalNote,
      threshold: threshold ?? this.threshold,
    );
  }

  // Utility method to check if item should be added to the shopping list
  bool get shouldAddToShoppingList {
    return quantity <= threshold || expiryDate.isBefore(DateTime.now());
  }

  @override
  String toString() {
    return 'Item(name: $name, quantity: $quantity, metric: $metric, purchaseDate: $purchaseDate, expiryDate: $expiryDate, additionalNote: $additionalNote, threshold: $threshold)';
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'metric': metric.name,
      'purchaseDate': purchaseDate.toString(),
      'expiryDate': expiryDate.toString(),
      'additionalNote': additionalNote,
      'threshold': threshold,
    };
  }

  // Deserialize from JSON
  static Item fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      metric: Metric.values.byName(json['metric'] as String),
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      additionalNote: json['additionalNote'] as String,
      threshold: json['threshold'] as int,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [name, quantity, metric, purchaseDate, expiryDate, additionalNote, threshold];
}
