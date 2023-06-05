import 'package:json_annotation/json_annotation.dart';

part 'province.g.dart';

@JsonSerializable()
class Province {
  final int id;
  @JsonKey(name: 'name_uz')
  final String nameUz;
  @JsonKey(name: 'name_oz')
  final String nameKr;
  @JsonKey(name: 'name_ru')
  final String nameRu;
  Province({
    required this.id,
    required this.nameUz,
    required this.nameKr,
    required this.nameRu,
  });

  /// Generate Class from Map<String, Object?>
  factory Province.fromJson(Map<String, Object?> json) =>
      _$ProvinceFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ProvinceToJson(this);
}
