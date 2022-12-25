// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable(explicitToJson: true)
class City {
  final int id;
  final String name;
  @JsonKey(name: 'provie_id')
  final Province provinceId;

  City({
    required this.id,
    required this.name,
    required this.provinceId,
  });

  factory City.fromJson(Map<String, Object?> json) => _$CityFromJson(json);

  Map<String, Object?> toJson() => _$CityToJson(this);
}

@JsonSerializable()
class Province {
  final int id;
  final String name;

  Province({
    required this.id,
    required this.name,
  });

  factory Province.fromJson(Map<String, Object?> json) =>
      _$ProvinceFromJson(json);

  Map<String, Object?> toJson() => _$ProvinceToJson(this);
}
