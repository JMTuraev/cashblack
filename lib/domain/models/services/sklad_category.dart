import 'package:json_annotation/json_annotation.dart';

import 'sklad_subcategory.dart';

part 'sklad_category.g.dart';

@JsonSerializable()
class SkladCategory {
  final String value;
  final String name;
  final List<SkladSubcategory> subcategories;

  SkladCategory({
    required this.value,
    required this.name,
    required this.subcategories,
  });

  /// Generate Class from Map<String, Object?>
  factory SkladCategory.fromJson(Map<String, Object?> json) =>
      _$SkladCategoryFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SkladCategoryToJson(this);
}
