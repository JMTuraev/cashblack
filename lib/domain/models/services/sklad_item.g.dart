// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sklad_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkladItem _$SkladItemFromJson(Map<String, dynamic> json) => SkladItem(
      id: json['id'] as String,
      name: json['name'] as String,
      attribute: json['attribute'] as String,
      category: json['category'] as String,
      subCategory: json['subCategory'] as String,
      createdDate: json['createdDate'] as String,
      quantity: json['quantity'] as String,
      pricePrixod: json['pricePrixod'] as String,
      priceSell: json['priceSell'] as String,
      priceSumOfAll: json['priceSumOfAll'] as String,
      serialNumber: json['serialNumber'] as String,
      partyNumber: json['partyNumber'] as String,
      skladDeliever: json['skladDeliever'] as String,
      skladItemStatus: json['skladItemStatus'] as String,
      minimumQuantity: json['minimumQuantity'] as String?,
    );

Map<String, dynamic> _$SkladItemToJson(SkladItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'attribute': instance.attribute,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'createdDate': instance.createdDate,
      'quantity': instance.quantity,
      'pricePrixod': instance.pricePrixod,
      'priceSell': instance.priceSell,
      'priceSumOfAll': instance.priceSumOfAll,
      'serialNumber': instance.serialNumber,
      'partyNumber': instance.partyNumber,
      'skladDeliever': instance.skladDeliever,
      'skladItemStatus': instance.skladItemStatus,
      'minimumQuantity': instance.minimumQuantity,
    };
