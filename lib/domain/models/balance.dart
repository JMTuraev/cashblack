import 'package:json_annotation/json_annotation.dart';

part 'balance.g.dart';

@JsonSerializable()
class Balance {
  final int id;
  @JsonKey(name: 'amunt')
  final String amount;
  final String date;

  Balance({
    required this.id,
    required this.amount,
    required this.date,
  });

  factory Balance.fromJson(Map<String, Object?> json) =>
      _$BalanceFromJson(json);

  Map<String, Object?> toJson() => _$BalanceToJson(this);
}
