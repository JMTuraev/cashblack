// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopNotification _$ShopNotificationFromJson(Map<String, dynamic> json) =>
    ShopNotification(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name_shops'] as String,
      cashback: json['cashback'] as int,
      category: json['categor_id'] as int,
      province: json['provinse_id'] as int,
      city: json['distrik_id'] as int,
      image: json['brand_img'] as String?,
    );

Map<String, dynamic> _$ShopNotificationToJson(ShopNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name_shops': instance.name,
      'brand_img': instance.image,
      'cashback': instance.cashback,
      'categor_id': instance.category,
      'provinse_id': instance.province,
      'distrik_id': instance.city,
    };
