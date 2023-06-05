// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientCategory _$ClientCategoryFromJson(Map<String, dynamic> json) =>
    ClientCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      title: json['title'] as String,
      logo: json['logo'],
      count: json['shop_count'] as int,
      shops: (json['shops'] as List<dynamic>)
          .map((e) => ClientShop.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientCategoryToJson(ClientCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'logo': instance.logo,
      'shop_count': instance.count,
      'shops': instance.shops,
    };
