import 'package:json_annotation/json_annotation.dart';

import 'warehouse_shop.dart';

part 'warehouse.g.dart';

@JsonSerializable()
class Warehouse {
  final int id;
  final String name;
  final String address;
  final WarehouseShop shop;

  Warehouse({
    required this.id,
    required this.name,
    required this.address,
    required this.shop,
  });

  /// Generate Class from Map<String, Object?>
  factory Warehouse.fromJson(Map<String, Object?> json) =>
      _$WarehouseFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$WarehouseToJson(this);
}
