// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sent_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentNotification _$SentNotificationFromJson(Map<String, dynamic> json) =>
    SentNotification(
      id: json['id'] as int,
      shop: ShopNotification.fromJson(json['shop_id'] as Map<String, dynamic>),
      title: json['title'] as String,
      content: json['content'] as String,
      status: json['status_id'] as int,
      date: json['date'] as String,
      payment: json['payment_summ'],
    );

Map<String, dynamic> _$SentNotificationToJson(SentNotification instance) =>
    <String, dynamic>{
      'shop_id': instance.shop,
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'status_id': instance.status,
      'date': instance.date,
      'payment_summ': instance.payment,
    };
