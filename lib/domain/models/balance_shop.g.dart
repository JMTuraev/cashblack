// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceShop _$BalanceShopFromJson(Map<String, dynamic> json) => BalanceShop(
      subscriptionPrice: json['payment_summ'] as String,
      createdDate: json['create_date'] as String,
    );

Map<String, dynamic> _$BalanceShopToJson(BalanceShop instance) =>
    <String, dynamic>{
      'payment_summ': instance.subscriptionPrice,
      'create_date': instance.createdDate,
    };
