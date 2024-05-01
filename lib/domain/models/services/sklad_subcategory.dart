import 'package:json_annotation/json_annotation.dart';

part 'sklad_subcategory.g.dart';

@JsonSerializable()
class SkladSubcategory {
  final String value;
  final String name;

  SkladSubcategory({
    required this.value,
    required this.name,
  });

  /// Generate Class from Map<String, Object?>
  factory SkladSubcategory.fromJson(Map<String, Object?> json) =>
      _$SkladSubcategoryFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SkladSubcategoryToJson(this);
}
