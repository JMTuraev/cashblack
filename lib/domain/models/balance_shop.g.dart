// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceShop _$BalanceShopFromJson(Map<String, dynamic> json) => BalanceShop(
      subscriptionPrice: json['payment_summ'] as String,
      isSubscribed: json['is_payment'] as bool,
      paymentDate: json['payemnt_date'] as String?,
      createdDate: json['create_date'] as String,
    );

Map<String, dynamic> _$BalanceShopToJson(BalanceShop instance) =>
    <String, dynamic>{
      'payment_summ': instance.subscriptionPrice,
      'is_payment': instance.isSubscribed,
      'payemnt_date': instance.paymentDate,
      'create_date': instance.createdDate,
    };
