// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientProfile _$ClientProfileFromJson(Map<String, dynamic> json) =>
    ClientProfile(
      id: json['id'] as int,
      phone: json['phone'] as String,
      nickname: json['nickname'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      districtId: json['district_id'] as String?,
      total: json['total'] as String,
      balance: json['balance'] as String,
      withdraw: json['withdraw'] as String,
      amount: json['amount'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ClientProfileToJson(ClientProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'nickname': instance.nickname,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'district_id': instance.districtId,
      'total': instance.total,
      'balance': instance.balance,
      'withdraw': instance.withdraw,
      'amount': instance.amount,
      'type': instance.type,
    };
