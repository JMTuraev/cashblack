// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCategory _$UserCategoryFromJson(Map<String, dynamic> json) => UserCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$UserCategoryToJson(UserCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };
