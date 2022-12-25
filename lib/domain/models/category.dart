import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String title;
  final String? logo;

  Category({
    required this.id,
    required this.title,
    this.logo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'logo': logo,
    };
  }

  factory Category.fromJson(Map<String, Object?> json) =>
      _$CategoryFromJson(json);

  Map<String, Object?> toJson() => _$CategoryToJson(this);
}
