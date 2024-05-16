import 'package:json_annotation/json_annotation.dart';

import 'warehouse_category.dart';

part 'warehouse_item.g.dart';

@JsonSerializable()
class WarehouseItem {
  final int id;
  final String name;
  final WarehouseCategory category;
// "user": {
//     "id": 121,
//     "name": "Owner Master"
// },
// "company": {
//     "id": 20,
//     "name": "Demo Company"
// },
// "category": {
//     "id": 2,
//     "name": "mebel"
// },
  @JsonKey(name: 'bar_code')
  final String barCode;
  final int code;
  final int lower;

  WarehouseItem({
    required this.id,
    required this.name,
    required this.category,
    required this.barCode,
    required this.code,
    required this.lower,
  });

  /// Generate Class from Map<String, Object?>
  factory WarehouseItem.fromJson(Map<String, Object?> json) =>
      _$WarehouseItemFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$WarehouseItemToJson(this);
}
