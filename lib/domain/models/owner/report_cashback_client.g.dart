// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_cashback_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportCashbackClient _$ReportCashbackClientFromJson(
        Map<String, dynamic> json) =>
    ReportCashbackClient(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      totalCashback: json['totalCashback'],
      cashback: json['cashback'],
      withdraw: json['withdraw'],
    );

Map<String, dynamic> _$ReportCashbackClientToJson(
        ReportCashbackClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'totalCashback': instance.totalCashback,
      'cashback': instance.cashback,
      'withdraw': instance.withdraw,
    };
