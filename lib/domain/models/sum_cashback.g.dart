// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sum_cashback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SumCashback _$SumCashbackFromJson(Map<String, dynamic> json) => SumCashback(
      name: json['name'] as String,
      phone: json['phone'] as String,
      sum: json['sums'] as int,
      cashback: (json['cashbak'] as num).toDouble(),
    );

Map<String, dynamic> _$SumCashbackToJson(SumCashback instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'sums': instance.sum,
      'cashbak': instance.cashback,
    };
