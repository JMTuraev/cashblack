// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_statistics_all.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientStatisticsAll _$ClientStatisticsAllFromJson(Map<String, dynamic> json) =>
    ClientStatisticsAll(
      allSum: json['all_sum'] as int,
      allCashback: (json['all_cashback'] as num).toDouble(),
      allTrueCashback: (json['all_true_cashback'] as num).toDouble(),
      allSeperateCashback: (json['all_seperate_cashback'] as num).toDouble(),
    );

Map<String, dynamic> _$ClientStatisticsAllToJson(
        ClientStatisticsAll instance) =>
    <String, dynamic>{
      'all_sum': instance.allSum,
      'all_cashback': instance.allCashback,
      'all_true_cashback': instance.allTrueCashback,
      'all_seperate_cashback': instance.allSeperateCashback,
    };
