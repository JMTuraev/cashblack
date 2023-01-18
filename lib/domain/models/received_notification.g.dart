// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'received_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivedNotification _$ReceivedNotificationFromJson(
        Map<String, dynamic> json) =>
    ReceivedNotification(
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['img'] as String,
      name: json['name_shops'] as String,
    );

Map<String, dynamic> _$ReceivedNotificationToJson(
        ReceivedNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'img': instance.image,
      'name_shops': instance.name,
    };
