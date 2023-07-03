// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientShop _$ClientShopFromJson(Map<String, dynamic> json) => ClientShop(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      address: json['address'] as String,
      waymark: json['waymark'] as String,
      percent: json['percent'] as String,
      categoryShopId: json['category_shop_id'] as int,
      clientCompany:
          ClientCompany.fromJson(json['company_id'] as Map<String, dynamic>),
      amount: json['amount'],
      cashback: (json['cashback'] as List<dynamic>)
          .map((e) => ClientCashback.fromJson(e as Map<String, dynamic>))
          .toList(),
      withdrawSum: json['withdraw_sum'],
      cashbackSum: json['cashback_sum'],
    );

Map<String, dynamic> _$ClientShopToJson(ClientShop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'address': instance.address,
      'waymark': instance.waymark,
      'percent': instance.percent,
      'category_shop_id': instance.categoryShopId,
      'company_id': instance.clientCompany,
      'amount': instance.amount,
      'cashback': instance.cashback,
      'withdraw_sum': instance.withdrawSum,
      'cashback_sum': instance.cashbackSum,
    };

ClientCompany _$ClientCompanyFromJson(Map<String, dynamic> json) =>
    ClientCompany(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ClientCompanyToJson(ClientCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
