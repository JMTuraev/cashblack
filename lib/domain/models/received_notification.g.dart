// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'received_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivedNotification _$ReceivedNotificationFromJson(
        Map<String, dynamic> json) =>
    ReceivedNotification(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      name: json['name_shops'] as String,
      category: json['catgoriya'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$ReceivedNotificationToJson(
        ReceivedNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'content': instance.content,
      'name_shops': instance.name,
      'catgoriya': instance.category,
      'date': instance.date,
    };
