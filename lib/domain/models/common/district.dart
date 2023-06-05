import 'package:json_annotation/json_annotation.dart';

import 'province.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
  final int id;
  @JsonKey(name: 'name_uz')
  final String nameUz;
  @JsonKey(name: 'name_oz')
  final String nameKr;
  @JsonKey(name: 'name_ru')
  final String nameRu;
  final Province province;
  District({
    required this.id,
    required this.nameUz,
    required this.nameKr,
    required this.nameRu,
    required this.province,
  });

  /// Generate Class from Map<String, Object?>
  factory District.fromJson(Map<String, Object?> json) =>
      _$DistrictFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$DistrictToJson(this);
}
