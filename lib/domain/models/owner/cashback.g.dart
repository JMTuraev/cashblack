// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cashback _$CashbackFromJson(Map<String, dynamic> json) => Cashback(
      companyName: json['company_name'] as String,
      companyLogo: json['company_logo'] as String?,
      sellerId: json['seller_id'] as int,
      sellerName: json['seller_name'] as String,
      sellerPhone: json['seller_phone'] as String,
      sellerType: json['seller_type'] as String,
      shopId: json['shop_id'] as int,
      shopName: json['shop_name'] as String,
      shopLogo: json['shop_logo'] as String?,
      percent: json['percent'] as String,
      totalPrice: json['total_price'] as String,
      amount: json['amount'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$CashbackToJson(Cashback instance) => <String, dynamic>{
      'company_name': instance.companyName,
      'company_logo': instance.companyLogo,
      'seller_id': instance.sellerId,
      'seller_name': instance.sellerName,
      'seller_phone': instance.sellerPhone,
      'seller_type': instance.sellerType,
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'shop_logo': instance.shopLogo,
      'percent': instance.percent,
      'total_price': instance.totalPrice,
      'amount': instance.amount,
      'date': instance.date,
    };
