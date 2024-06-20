// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_owner_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerOwnerProfile _$SellerOwnerProfileFromJson(Map<String, dynamic> json) =>
    SellerOwnerProfile(
      id: json['id'] as int,
      phone: json['phone'] as String,
      nickname: json['nickname'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      districtId: json['district_id'] as String?,
      balance: json['balance'],
      total: json['total'],
      withdraw: json['withdraw'],
      amount: json['amount'],
      licence: (json['licence'] as List<dynamic>)
          .map((e) => BusinessLicense.fromJson(e as Map<String, dynamic>))
          .toList(),
      shop: BusinessShop.fromJson(json['shop_id'] as Map<String, dynamic>),
      status: json['status'] as int,
    );

Map<String, dynamic> _$SellerOwnerProfileToJson(SellerOwnerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'nickname': instance.nickname,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'district_id': instance.districtId,
      'balance': instance.balance,
      'total': instance.total,
      'withdraw': instance.withdraw,
      'amount': instance.amount,
      'status': instance.status,
      'licence': instance.licence,
      'shop_id': instance.shop,
    };
