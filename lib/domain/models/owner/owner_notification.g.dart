// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerNotification _$OwnerNotificationFromJson(Map<String, dynamic> json) =>
    OwnerNotification(
      type: json['type'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      image: json['image'] as String?,
      endAt: json['end_at'] as String,
      updatedAt: json['updated_at'] as String,
      adminId: json['admin_id'],
      status: json['status'] as String,
      remark: json['remark'],
      showed: json['showed'] as bool,
      showedCount: json['showed_count'] as int,
      like: json['like'] as bool,
      likeCount: json['like_count'] as int,
    );

Map<String, dynamic> _$OwnerNotificationToJson(OwnerNotification instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'text': instance.text,
      'image': instance.image,
      'end_at': instance.endAt,
      'updated_at': instance.updatedAt,
      'admin_id': instance.adminId,
      'status': instance.status,
      'remark': instance.remark,
      'showed': instance.showed,
      'showed_count': instance.showedCount,
      'like': instance.like,
      'like_count': instance.likeCount,
    };
