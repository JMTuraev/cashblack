// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bonus_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BonusPrice _$BonusPriceFromJson(Map<String, dynamic> json) => BonusPrice(
      id: json['id'] as int,
      amount: json['amount'] as String,
      bonus: json['bonus'] as String,
    );

Map<String, dynamic> _$BonusPriceToJson(BonusPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'bonus': instance.bonus,
    };
