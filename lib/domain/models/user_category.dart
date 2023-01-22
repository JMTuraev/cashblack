import 'package:json_annotation/json_annotation.dart';

part 'user_category.g.dart';

@JsonSerializable()
class UserCategory {
  UserCategory({
    required this.id,
    required this.name,
    required this.logo,
    this.count,
  });

  final int id;
  final String name;
  final String logo;
  @JsonKey(name: 'count_shop')
  final int? count;

  factory UserCategory.fromJson(Map<String, Object?> json) =>
      _$UserCategoryFromJson(json);

  Map<String, Object?> toJson() => _$UserCategoryToJson(this);
}
