// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      amount: json['amount'] as String,
      cardNumber: json['card_number'] as String,
      date: json['payment_date'] as String,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'amount': instance.amount,
      'card_number': instance.cardNumber,
      'payment_date': instance.date,
    };
