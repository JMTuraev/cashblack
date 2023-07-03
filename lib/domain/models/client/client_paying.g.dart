// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_paying.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientPaying _$ClientPayingFromJson(Map<String, dynamic> json) => ClientPaying(
      id: json['id'] as int,
      companyLogo: json['company_logo'] as String?,
      companyName: json['company_name'] as String,
      shopId: json['shop_id'] as int,
      shopName: json['shop_name'] as String,
      shopLogo: json['shop_logo'] as String?,
      clientId: json['client_id'] as int,
      sellerName: json['seller_name'] as String,
      sellerId: json['seller_id'] as int,
      totalPrice: json['total_price'],
      amount: json['amount'],
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$ClientPayingToJson(ClientPaying instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_logo': instance.companyLogo,
      'company_name': instance.companyName,
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'shop_logo': instance.shopLogo,
      'client_id': instance.clientId,
      'seller_name': instance.sellerName,
      'seller_id': instance.sellerId,
      'total_price': instance.totalPrice,
      'amount': instance.amount,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
