// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name_shops'] as String,
      cashback: json['cashback'] as int,
      category: Category.fromJson(json['categor_id'] as Map<String, dynamic>),
      province: Province.fromJson(json['provinse_id'] as Map<String, dynamic>),
      city: City.fromJson(json['distrik_id'] as Map<String, dynamic>),
      image: json['brand_img'] as String?,
      subscriptionPrice: json['payment_summ'] as String,
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name_shops': instance.name,
      'brand_img': instance.image,
      'cashback': instance.cashback,
      'categor_id': instance.category,
      'provinse_id': instance.province,
      'distrik_id': instance.city,
      'payment_summ': instance.subscriptionPrice,
    };
