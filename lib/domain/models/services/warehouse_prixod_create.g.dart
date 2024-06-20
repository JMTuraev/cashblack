// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_prixod_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehousePrixodCreate _$WarehousePrixodCreateFromJson(
        Map<String, dynamic> json) =>
    WarehousePrixodCreate(
      productiId: json['productiId'] as String,
      quantity: json['quantity'] as String,
      unitId: json['unitId'] as String,
      price: json['price'] as String,
      priceSell: json['priceSell'] as String,
    );

Map<String, dynamic> _$WarehousePrixodCreateToJson(
        WarehousePrixodCreate instance) =>
    <String, dynamic>{
      'productiId': instance.productiId,
      'quantity': instance.quantity,
      'unitId': instance.unitId,
      'price': instance.price,
      'priceSell': instance.priceSell,
    };
