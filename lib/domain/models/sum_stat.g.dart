// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sum_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SumStat _$SumStatFromJson(Map<String, dynamic> json) => SumStat(
      userName: json['phone'] as String,
      price: json['price'] as int,
      cashback: (json['cashback'] as num).toDouble(),
      fullName: json['full_name'] as String?,
      salesman: json['salesman'] as String?,
      date: json['date'] as String?,
      isWithdraw: json['true_false'] as bool,
    );

Map<String, dynamic> _$SumStatToJson(SumStat instance) => <String, dynamic>{
      'phone': instance.userName,
      'full_name': instance.fullName,
      'price': instance.price,
      'cashback': instance.cashback,
      'salesman': instance.salesman,
      'date': instance.date,
      'true_false': instance.isWithdraw,
    };
