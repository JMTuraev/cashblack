// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seller _$SellerFromJson(Map<String, dynamic> json) => Seller(
      id: json['id'] as int,
      phone: json['phone'] as String,
      nickname: json['nickname'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'nickname': instance.nickname,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'type': instance.type,
    };
