// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_month_statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneMonthStatistic _$OneMonthStatisticFromJson(Map<String, dynamic> json) =>
    OneMonthStatistic(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      price: json['sum_price'] as int?,
      cashback: (json['sum_cashback'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OneMonthStatisticToJson(OneMonthStatistic instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'sum_price': instance.price,
      'sum_cashback': instance.cashback,
    };
