import 'package:json_annotation/json_annotation.dart';

part 'balance_shop.g.dart';

@JsonSerializable()
class BalanceShop {
  @JsonKey(name: 'payment_summ')
  final String subscriptionPrice;
  // @JsonKey(name: 'is_payment')
  // final bool isSubscribed;
  // @JsonKey(name: 'payemnt_date')
  // String? paymentDate;
  @JsonKey(name: 'create_date')
  final String createdDate;

  BalanceShop({
    required this.subscriptionPrice,
    // required this.isSubscribed,
    // this.paymentDate,
    required this.createdDate,
  });

  factory BalanceShop.fromJson(Map<String, Object?> json) =>
      _$BalanceShopFromJson(json);

  Map<String, Object?> toJson() => _$BalanceShopToJson(this);
}
