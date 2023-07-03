// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessCompany _$BusinessCompanyFromJson(Map<String, dynamic> json) =>
    BusinessCompany(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      inn: json['inn'] as String,
      address: json['address'] as String,
      passwordId: json['p_seria'] as String,
      pinfl: json['pinfl'] as String,
      district: District.fromJson(json['district'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BusinessCompanyToJson(BusinessCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'inn': instance.inn,
      'address': instance.address,
      'p_seria': instance.passwordId,
      'pinfl': instance.pinfl,
      'district': instance.district,
    };
