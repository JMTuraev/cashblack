// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_license.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessLicense _$BusinessLicenseFromJson(Map<String, dynamic> json) =>
    BusinessLicense(
      price: BusinessLicensePrice.fromJson(
          json['price_id'] as Map<String, dynamic>),
      amount: json['amount'] as String,
      startAt: json['start_at'] as String,
      endAt: json['end_at'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$BusinessLicenseToJson(BusinessLicense instance) =>
    <String, dynamic>{
      'price_id': instance.price,
      'amount': instance.amount,
      'start_at': instance.startAt,
      'end_at': instance.endAt,
      'created_at': instance.createdAt,
    };

BusinessLicensePrice _$BusinessLicensePriceFromJson(
        Map<String, dynamic> json) =>
    BusinessLicensePrice(
      id: json['id'] as int,
      type: json['type'] as String,
      price: json['price'] as String,
      days: json['days'] as int?,
      month: json['month'] as int,
    );

Map<String, dynamic> _$BusinessLicensePriceToJson(
        BusinessLicensePrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'price': instance.price,
      'days': instance.days,
      'month': instance.month,
    };
