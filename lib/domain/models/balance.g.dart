// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
      id: json['id'] as int,
      amount: json['amunt'] as String,
      date: json['last_date'] as String,
      balanceShop:
          BalanceShop.fromJson(json['shop_id'] as Map<String, dynamic>),
      isSubscribedOne: json['is_date'] as bool,
    );

Map<String, dynamic> _$BalanceToJson(Balance instance) => <String, dynamic>{
      'id': instance.id,
      'amunt': instance.amount,
      'last_date': instance.date,
      'shop_id': instance.balanceShop,
      'is_date': instance.isSubscribedOne,
    };
