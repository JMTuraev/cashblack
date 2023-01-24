// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Worker _$WorkerFromJson(Map<String, dynamic> json) => Worker(
      id: json['id'] as int,
      userName: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      isFreezed: json['is_switcher'] as bool,
    );

Map<String, dynamic> _$WorkerToJson(Worker instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.userName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'is_switcher': instance.isFreezed,
    };
