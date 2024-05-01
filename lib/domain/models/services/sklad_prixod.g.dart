// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sklad_prixod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkladPrixod _$SkladPrixodFromJson(Map<String, dynamic> json) => SkladPrixod(
      dateTime: json['dateTime'] as String,
      skladItems: (json['skladItems'] as List<dynamic>)
          .map((e) => SkladItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SkladPrixodToJson(SkladPrixod instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime,
      'skladItems': instance.skladItems,
    };
