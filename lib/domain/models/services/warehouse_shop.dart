import 'package:json_annotation/json_annotation.dart';

part 'warehouse_shop.g.dart';

@JsonSerializable()
class WarehouseShop {
  final int id;
  final String name;

  WarehouseShop({
    required this.id,
    required this.name,
  });

  /// Generate Class from Map<String, Object?>
  factory WarehouseShop.fromJson(Map<String, Object?> json) =>
      _$WarehouseShopFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$WarehouseShopToJson(this);
}
