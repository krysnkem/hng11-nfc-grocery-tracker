
import 'package:grocey_tag/core/enums/enum.dart';

class Item {
  const Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.purchaseDate,
    required this.expiryDate,
    required this.additionalNote,
  });
  
  final String id;
  final String name;
  final int quantity;
  final Unit unit;
  final DateTime purchaseDate;
  final DateTime expiryDate;
  final String additionalNote;

  Item copyWith({
    String? id,
    String? name,
    int? quantity,
    Unit? unit,
    DateTime? purchaseDate,
    DateTime? expiryDate,
    String? additionalNote,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expiryDate: expiryDate ?? this.expiryDate,
      additionalNote: additionalNote ?? this.additionalNote,
    );
  }

  @override
  String toString() {
    return 'Item(id: $id, name: $name, quantity: $quantity, unit: $unit, purchaseDate: $purchaseDate, expiryDate: $expiryDate, additionalNote: $additionalNote)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit.name,
      'purchaseDate': purchaseDate.toString(),
      'expiryDate': expiryDate.toString(),
      'additionalNote': additionalNote,
    };
  }

  static Item fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      unit: Unit.values.byName(json['unit'] as String),
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      additionalNote: json['additionalNote'] as String,
    );
  }
}
