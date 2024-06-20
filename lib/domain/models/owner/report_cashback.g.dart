// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_cashback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportCashback _$ReportCashbackFromJson(Map<String, dynamic> json) =>
    ReportCashback(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      address: json['address'] as String,
      waymark: json['waymark'] as String,
      percent: json['percent'] as String,
      categoryShopId: json['category_shop_id'] as int,
      companyId:
          ClientCompany.fromJson(json['company_id'] as Map<String, dynamic>),
      amount: json['amount'],
      withdrawSum: json['withdraw_sum'],
      cashbackSum: json['cashback_sum'],
      withdraw: (json['withdraw'] as List<dynamic>)
          .map((e) =>
              InlineCashbackAndWithdraw.fromJson(e as Map<String, dynamic>))
          .toList(),
      cashback: (json['cashback'] as List<dynamic>)
          .map((e) =>
              InlineCashbackAndWithdraw.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportCashbackToJson(ReportCashback instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'address': instance.address,
      'waymark': instance.waymark,
      'percent': instance.percent,
      'category_shop_id': instance.categoryShopId,
      'company_id': instance.companyId,
      'amount': instance.amount,
      'withdraw_sum': instance.withdrawSum,
      'cashback_sum': instance.cashbackSum,
      'withdraw': instance.withdraw,
      'cashback': instance.cashback,
    };

InlineCashbackAndWithdraw _$InlineCashbackAndWithdrawFromJson(
        Map<String, dynamic> json) =>
    InlineCashbackAndWithdraw(
      type: json['type'] as String,
      companyName: json['company_name'] as String,
      companyLogo: json['company_logo'] as String?,
      sellerName: json['seller_name'] as String,
      sellerPhone: json['seller_phone'] as String,
      shopId: json['shop_id'] as int,
      shopName: json['shop_name'] as String,
      shopLogo: json['shop_logo'] as String?,
      percent: json['percent'] as String?,
      totalPrice: json['total_price'] as String?,
      clientId: json['client_id'] as int,
      clientName: json['client'] as String,
      clientPhone: json['client_phone'] as String,
      amount: json['amount'],
      date: json['date'] as String,
    );

Map<String, dynamic> _$InlineCashbackAndWithdrawToJson(
        InlineCashbackAndWithdraw instance) =>
    <String, dynamic>{
      'type': instance.type,
      'company_name': instance.companyName,
      'company_logo': instance.companyLogo,
      'seller_name': instance.sellerName,
      'seller_phone': instance.sellerPhone,
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'shop_logo': instance.shopLogo,
      'percent': instance.percent,
      'total_price': instance.totalPrice,
      'client_id': instance.clientId,
      'client': instance.clientName,
      'client_phone': instance.clientPhone,
      'amount': instance.amount,
      'date': instance.date,
    };
