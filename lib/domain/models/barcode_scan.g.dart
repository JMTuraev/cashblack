// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_scan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeScan _$BarcodeScanFromJson(Map<String, dynamic> json) => BarcodeScan(
      datum: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      cashback: (json['cashback'] as num).toDouble(),
    );

Map<String, dynamic> _$BarcodeScanToJson(BarcodeScan instance) =>
    <String, dynamic>{
      'data': instance.datum,
      'cashback': instance.cashback,
    };
