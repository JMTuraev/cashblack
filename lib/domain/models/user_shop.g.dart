// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShop _$UserShopFromJson(Map<String, dynamic> json) => UserShop(
      id: json['id'] as int,
      name: json['name_shop'] as String,
      logo: json['brand_img'] as String,
      cashbackPercentage: json['cashback_persent'] as int,
    );

Map<String, dynamic> _$UserShopToJson(UserShop instance) => <String, dynamic>{
      'id': instance.id,
      'name_shop': instance.name,
      'brand_img': instance.logo,
      'cashback_persent': instance.cashbackPercentage,
    };
