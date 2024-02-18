import 'package:json_annotation/json_annotation.dart';

import '../owner/report_cashback.dart';
import 'client_cashback.dart';

part 'client_shop.g.dart';

@JsonSerializable()
class ClientShop {
  final int id;
  final String name;
  final String? logo;
  final String address;
  final String waymark;
  final String percent;
  @JsonKey(name: 'category_shop_id')
  final int categoryShopId;
  @JsonKey(name: 'company_id')
  final ClientCompany clientCompany;
  final dynamic amount;
  final List<InlineCashbackAndWithdraw> cashback;
  final List<InlineCashbackAndWithdraw> withdraw;
  @JsonKey(name: 'withdraw_sum')
  final dynamic withdrawSum;
  @JsonKey(name: 'cashback_sum')
  final dynamic cashbackSum;
  ClientShop({
    required this.id,
    required this.name,
    required this.logo,
    required this.address,
    required this.waymark,
    required this.percent,
    required this.categoryShopId,
    required this.clientCompany,
    required this.amount,
    required this.cashback,
    required this.withdraw,
    required this.withdrawSum,
    required this.cashbackSum,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientShop.fromJson(Map<String, Object?> json) =>
      _$ClientShopFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientShopToJson(this);
}

@JsonSerializable()
class ClientCompany {
  final int id;
  final String name;

  ClientCompany({
    required this.id,
    required this.name,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientCompany.fromJson(Map<String, Object?> json) =>
      _$ClientCompanyFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientCompanyToJson(this);
}
