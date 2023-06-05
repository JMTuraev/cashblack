// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPrice _$NotificationPriceFromJson(Map<String, dynamic> json) =>
    NotificationPrice(
      id: json['id'] as int,
      type: json['type'] as String,
      price: json['price'] as String,
      days: json['days'] as int,
      month: json['month'] as int?,
    );

Map<String, dynamic> _$NotificationPriceToJson(NotificationPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'price': instance.price,
      'days': instance.days,
      'month': instance.month,
    };
