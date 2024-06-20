// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerProfile _$SellerProfileFromJson(Map<String, dynamic> json) =>
    SellerProfile(
      id: json['id'] as int,
      phone: json['phone'] as String,
      nickname: json['nickname'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      districtId: json['district_id'] as String?,
      shop: BusinessShopLite.fromJson(json['shop'] as Map<String, dynamic>),
      type: json['type'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$SellerProfileToJson(SellerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'nickname': instance.nickname,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'district_id': instance.districtId,
      'shop': instance.shop,
      'type': instance.type,
      'status': instance.status,
    };
