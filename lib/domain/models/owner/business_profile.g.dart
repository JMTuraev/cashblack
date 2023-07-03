// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessProfile _$BusinessProfileFromJson(Map<String, dynamic> json) =>
    BusinessProfile(
      id: json['id'] as int,
      phone: json['phone'] as String,
      nickname: json['nickname'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      districtId: json['district_id'] as String?,
      balance: json['balance'] as String,
      totalAmount: json['total_amount'] as String,
      totalExpense: json['total_expense'] as String,
      type: json['type'] as String,
      licence: (json['licence'] as List<dynamic>)
          .map((e) => BusinessLicense.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusinessProfileToJson(BusinessProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'nickname': instance.nickname,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'district_id': instance.districtId,
      'balance': instance.balance,
      'total_amount': instance.totalAmount,
      'total_expense': instance.totalExpense,
      'type': instance.type,
      'licence': instance.licence,
    };
