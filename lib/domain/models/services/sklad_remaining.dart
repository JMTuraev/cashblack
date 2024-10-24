// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'warehouse_item.dart';

class SkladRemaining {
  double quantity;
  final String warehouseItemId;
  final WarehouseItem warehouseItem;

  SkladRemaining({
    required this.quantity,
    required this.warehouseItemId,
    required this.warehouseItem,
  });

  SkladRemaining copyWith({
    double? quantity,
    String? warehouseItemId,
    WarehouseItem? warehouseItem,
  }) {
    return SkladRemaining(
      quantity: quantity ?? this.quantity,
      warehouseItemId: warehouseItemId ?? this.warehouseItemId,
      warehouseItem: warehouseItem ?? this.warehouseItem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'warehouseItemId': warehouseItemId,
      'warehouseItem': warehouseItem.toMap(),
    };
  }

  factory SkladRemaining.fromMap(Map<String, dynamic> map) {
    return SkladRemaining(
      quantity: map['quantity'] as double,
      warehouseItemId: map['warehouseItemId'] as String,
      warehouseItem:
          WarehouseItem.fromMap(map['warehouseItem'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SkladRemaining.fromJson(String source) =>
      SkladRemaining.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SkladRemaining(quantity: $quantity, warehouseItemId: $warehouseItemId, warehouseItem: $warehouseItem)';

  @override
  bool operator ==(covariant SkladRemaining other) {
    if (identical(this, other)) return true;

    return other.quantity == quantity &&
        other.warehouseItemId == warehouseItemId &&
        other.warehouseItem == warehouseItem;
  }

  @override
  int get hashCode =>
      quantity.hashCode ^ warehouseItemId.hashCode ^ warehouseItem.hashCode;
}
