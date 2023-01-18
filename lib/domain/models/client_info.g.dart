// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientInfo _$ClientInfoFromJson(Map<String, dynamic> json) => ClientInfo(
      fullName: json['full_name'] as String,
      price: json['price'] as int,
      cashback: (json['cashback'] as num).toDouble(),
      date: json['date'] as String,
      isWithdraw: json['cashback_True_False'] as bool,
    );

Map<String, dynamic> _$ClientInfoToJson(ClientInfo instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'price': instance.price,
      'cashback': instance.cashback,
      'date': instance.date,
      'cashback_True_False': instance.isWithdraw,
    };
