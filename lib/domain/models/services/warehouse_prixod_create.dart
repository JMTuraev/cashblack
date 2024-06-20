import 'package:json_annotation/json_annotation.dart';

part 'warehouse_prixod_create.g.dart';

@JsonSerializable()
class WarehousePrixodCreate {
  final String productiId;
  final String quantity;
  final String unitId;
  final String price;
  final String priceSell;

  WarehousePrixodCreate({
    required this.productiId,
    required this.quantity,
    required this.unitId,
    required this.price,
    required this.priceSell,
  });

  /// Generate Class from Map<String, Object?>
  factory WarehousePrixodCreate.fromJson(Map<String, Object?> json) =>
      _$WarehousePrixodCreateFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$WarehousePrixodCreateToJson(this);
}
