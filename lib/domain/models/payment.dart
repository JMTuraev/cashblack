import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  final String amount;
  @JsonKey(name: 'card_number')
  final String cardNumber;
  @JsonKey(name: 'payment_date')
  final String date;
  Payment({
    required this.amount,
    required this.cardNumber,
    required this.date,
  });

  factory Payment.fromJson(Map<String, Object?> json) =>
      _$PaymentFromJson(json);

  Map<String, Object?> toJson() => _$PaymentToJson(this);
}
