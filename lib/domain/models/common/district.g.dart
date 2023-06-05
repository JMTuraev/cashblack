// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

District _$DistrictFromJson(Map<String, dynamic> json) => District(
      id: json['id'] as int,
      nameUz: json['name_uz'] as String,
      nameKr: json['name_oz'] as String,
      nameRu: json['name_ru'] as String,
      province: Province.fromJson(json['province'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'id': instance.id,
      'name_uz': instance.nameUz,
      'name_oz': instance.nameKr,
      'name_ru': instance.nameRu,
      'province': instance.province,
    };
