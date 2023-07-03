// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyStat _$WeeklyStatFromJson(Map<String, dynamic> json) => WeeklyStat(
      totalCashback: json['totalCashback'],
      cashback: json['cashback'],
      withdraw: json['withdraw'],
      date: json['date'],
    );

Map<String, dynamic> _$WeeklyStatToJson(WeeklyStat instance) =>
    <String, dynamic>{
      'totalCashback': instance.totalCashback,
      'cashback': instance.cashback,
      'withdraw': instance.withdraw,
      'date': instance.date,
    };
