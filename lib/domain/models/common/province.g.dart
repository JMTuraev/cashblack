// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Province _$ProvinceFromJson(Map<String, dynamic> json) => Province(
      id: json['id'] as int,
      nameUz: json['name_uz'] as String,
      nameKr: json['name_oz'] as String,
      nameRu: json['name_ru'] as String,
    );

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'id': instance.id,
      'name_uz': instance.nameUz,
      'name_oz': instance.nameKr,
      'name_ru': instance.nameRu,
    };
