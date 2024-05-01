import 'package:json_annotation/json_annotation.dart';

part 'sklad_item.g.dart';

@JsonSerializable()
class SkladItem {
  final String id;
  final String name;
  final String attribute;
  final String category;
  final String subCategory;
  final String createdDate;
  final String quantity;
  final String pricePrixod;
  final String priceSell;
  final String priceSumOfAll;
  final String serialNumber;
  final String partyNumber;
  final String skladDeliever;
  final String skladItemStatus;
  final String? minimumQuantity;

  SkladItem({
    required this.id,
    required this.name,
    required this.attribute,
    required this.category,
    required this.subCategory,
    required this.createdDate,
    required this.quantity,
    required this.pricePrixod,
    required this.priceSell,
    required this.priceSumOfAll,
    required this.serialNumber,
    required this.partyNumber,
    required this.skladDeliever,
    required this.skladItemStatus,
    required this.minimumQuantity,
  });

  /// Generate Class from Map<String, Object?>
  factory SkladItem.fromJson(Map<String, Object?> json) =>
      _$SkladItemFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SkladItemToJson(this);
}
