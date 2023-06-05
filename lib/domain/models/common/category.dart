import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String title;
  @JsonKey(name: 'name_slug')
  final String slug;
  Category({
    required this.id,
    required this.name,
    required this.title,
    required this.slug,
  });

  /// Generate Class from Map<String, Object?>
  factory Category.fromJson(Map<String, Object?> json) =>
      _$CategoryFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$CategoryToJson(this);
}
