// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sklad_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkladCategory _$SkladCategoryFromJson(Map<String, dynamic> json) =>
    SkladCategory(
      value: json['value'] as String,
      name: json['name'] as String,
      subcategories: (json['subcategories'] as List<dynamic>)
          .map((e) => SkladSubcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SkladCategoryToJson(SkladCategory instance) =>
    <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
      'subcategories': instance.subcategories,
    };
