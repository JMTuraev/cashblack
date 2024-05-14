import 'package:json_annotation/json_annotation.dart';

part 'warehouse_category.g.dart';

@JsonSerializable()
class WarehouseCategory {
  final int id;
  final String name;
  final String title;
  // final WarehouseCategory? parent;
  // @JsonKey(name: 'childrens')
  // final List<WarehouseCategory> children;

  WarehouseCategory({
    required this.id,
    required this.name,
    required this.title,
    // required this.parent,
    // required this.children,
  });

  /// Generate Class from Map<String, Object?>
  factory WarehouseCategory.fromJson(Map<String, Object?> json) =>
      _$WarehouseCategoryFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$WarehouseCategoryToJson(this);
}
