// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sum_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SumStat _$SumStatFromJson(Map<String, dynamic> json) => SumStat(
      userName: json['phone'] as String,
      price: json['price'] as String,
      cashback: (json['cashback'] as num).toDouble(),
      salesman: json['salesman'] as String?,
      date: json['date'] as String,
    );

Map<String, dynamic> _$SumStatToJson(SumStat instance) => <String, dynamic>{
      'phone': instance.userName,
      'price': instance.price,
      'cashback': instance.cashback,
      'salesman': instance.salesman,
      'date': instance.date,
    };
