import 'package:json_annotation/json_annotation.dart';

part 'warehouse_unit.g.dart';

@JsonSerializable()
class WarehouseUnit {
  final int id;
  final String name;
  final String title;

  WarehouseUnit({
    required this.id,
    required this.name,
    required this.title,
  });

  /// Generate Class from Map<String, Object?>
  factory WarehouseUnit.fromJson(Map<String, Object?> json) =>
      _$WarehouseUnitFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$WarehouseUnitToJson(this);
}
