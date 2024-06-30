// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessShop _$BusinessShopFromJson(Map<String, dynamic> json) => BusinessShop(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      address: json['address'] as String,
      waymark: json['waymark'] as String,
      percent: json['percent'] as String,
      categoryShopId: json['category_shop_id'] as int,
      businessCompanyLite: BusinessCompanyLite.fromJson(
          json['company_id'] as Map<String, dynamic>),
      amount: json['amount'],
      sellers: (json['sellers'] as List<dynamic>)
          .map((e) => Seller.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool,
    );

Map<String, dynamic> _$BusinessShopToJson(BusinessShop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'address': instance.address,
      'waymark': instance.waymark,
      'percent': instance.percent,
      'amount': instance.amount,
      'category_shop_id': instance.categoryShopId,
      'company_id': instance.businessCompanyLite,
      'sellers': instance.sellers,
      'status': instance.status,
    };

BusinessCompanyLite _$BusinessCompanyLiteFromJson(Map<String, dynamic> json) =>
    BusinessCompanyLite(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BusinessCompanyLiteToJson(
        BusinessCompanyLite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
