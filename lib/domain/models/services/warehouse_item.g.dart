// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseItem _$WarehouseItemFromJson(Map<String, dynamic> json) =>
    WarehouseItem(
      id: json['id'] as int,
      name: json['name'] as String,
      category:
          WarehouseCategory.fromJson(json['category'] as Map<String, dynamic>),
      barCode: json['bar_code'] as String,
      code: json['code'] as int,
      lower: json['lower'] as int,
    );

Map<String, dynamic> _$WarehouseItemToJson(WarehouseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'bar_code': instance.barCode,
      'code': instance.code,
      'lower': instance.lower,
    };
