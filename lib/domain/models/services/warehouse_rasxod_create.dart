// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'warehouse_item.dart';

class WarehouseRasxodCreate {
  final String client;
  final WarehouseItem warehouseItem;
  final int quantity;
  final String priceSellSingle;
  final String priceSellAll;

  WarehouseRasxodCreate({
    required this.client,
    required this.warehouseItem,
    required this.quantity,
    required this.priceSellSingle,
    required this.priceSellAll,
  });

  WarehouseRasxodCreate copyWith({
    String? client,
    WarehouseItem? warehouseItem,
    int? quantity,
    String? priceSellSingle,
    String? priceSellAll,
  }) {
    return WarehouseRasxodCreate(
      client: client ?? this.client,
      warehouseItem: warehouseItem ?? this.warehouseItem,
      quantity: quantity ?? this.quantity,
      priceSellSingle: priceSellSingle ?? this.priceSellSingle,
      priceSellAll: priceSellAll ?? this.priceSellAll,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'client': client,
      'warehouseItem': warehouseItem.toMap(),
      'quantity': quantity,
      'priceSellSingle': priceSellSingle,
      'priceSellAll': priceSellAll,
    };
  }

  factory WarehouseRasxodCreate.fromMap(Map<String, dynamic> map) {
    return WarehouseRasxodCreate(
      client: map['client'] as String,
      warehouseItem:
          WarehouseItem.fromMap(map['warehouseItem'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      priceSellSingle: map['priceSellSingle'] as String,
      priceSellAll: map['priceSellAll'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WarehouseRasxodCreate.fromJson(String source) =>
      WarehouseRasxodCreate.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WarehouseRasxodCreate(client: $client, warehouseItem: $warehouseItem, quantity: $quantity, priceSellSingle: $priceSellSingle, priceSellAll: $priceSellAll)';
  }

  @override
  bool operator ==(covariant WarehouseRasxodCreate other) {
    if (identical(this, other)) return true;

    return other.client == client &&
        other.warehouseItem == warehouseItem &&
        other.quantity == quantity &&
        other.priceSellSingle == priceSellSingle &&
        other.priceSellAll == priceSellAll;
  }

  @override
  int get hashCode {
    return client.hashCode ^
        warehouseItem.hashCode ^
        quantity.hashCode ^
        priceSellSingle.hashCode ^
        priceSellAll.hashCode;
  }
}
