// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseProvider _$WarehouseProviderFromJson(Map<String, dynamic> json) =>
    WarehouseProvider(
      id: json['id'] as int,
      companyId: json['company_id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$WarehouseProviderToJson(WarehouseProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };
