// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sent_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentNotification _$SentNotificationFromJson(Map<String, dynamic> json) =>
    SentNotification(
      shop: ShopNotification.fromJson(json['shop_id'] as Map<String, dynamic>),
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['img'] as String,
      status: json['status_id'] as int,
      date: json['date'] as String,
      payment: json['payment_summ'],
    );

Map<String, dynamic> _$SentNotificationToJson(SentNotification instance) =>
    <String, dynamic>{
      'shop_id': instance.shop,
      'title': instance.title,
      'content': instance.content,
      'img': instance.image,
      'status_id': instance.status,
      'date': instance.date,
      'payment_summ': instance.payment,
    };
