// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientStatistics _$ClientStatisticsFromJson(Map<String, dynamic> json) =>
    ClientStatistics(
      allSum: json['all_sum'] as int,
      allCashback: (json['all_cashback'] as num).toDouble(),
      allTrueCashback: json['all_true_cashback'] as int,
      allSeperateCashback: (json['all_seperate_cashback'] as num).toDouble(),
      clientInfo: (json['client_info'] as List<dynamic>)
          .map((e) => ClientInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientStatisticsToJson(ClientStatistics instance) =>
    <String, dynamic>{
      'all_sum': instance.allSum,
      'all_cashback': instance.allCashback,
      'all_true_cashback': instance.allTrueCashback,
      'all_seperate_cashback': instance.allSeperateCashback,
      'client_info': instance.clientInfo,
    };
