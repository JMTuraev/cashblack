import 'package:json_annotation/json_annotation.dart';

import 'balance_shop.dart';

part 'balance.g.dart';

@JsonSerializable()
class Balance {
  final int id;
  @JsonKey(name: 'amunt')
  final String amount;
  final String date;
  @JsonKey(name: 'shop_id')
  final BalanceShop balanceShop;

  Balance({
    required this.id,
    required this.amount,
    required this.date,
    required this.balanceShop,
  });

  factory Balance.fromJson(Map<String, Object?> json) =>
      _$BalanceFromJson(json);

  Map<String, Object?> toJson() => _$BalanceToJson(this);
}
