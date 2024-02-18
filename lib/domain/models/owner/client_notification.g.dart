// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientNotification _$ClientNotificationFromJson(Map<String, dynamic> json) =>
    ClientNotification(
      count: json['count'] as int,
      notifications: (json['data'] as List<dynamic>)
          .map((e) => OwnerNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientNotificationToJson(ClientNotification instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.notifications,
    };
