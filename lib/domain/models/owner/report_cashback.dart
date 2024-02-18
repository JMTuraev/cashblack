// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import '../client/client_shop.dart';

part 'report_cashback.g.dart';

@JsonSerializable()
class ReportCashback {
  final int id;
  final String name;
  final String? logo;
  final String address;
  final String waymark;
  final String percent;
  @JsonKey(name: 'category_shop_id')
  final int categoryShopId;
  @JsonKey(name: 'company_id')
  final ClientCompany companyId;
  final dynamic amount;
  @JsonKey(name: 'withdraw_sum')
  final dynamic withdrawSum;
  @JsonKey(name: 'cashback_sum')
  final dynamic cashbackSum;
  final List<InlineCashbackAndWithdraw> withdraw;
  final List<InlineCashbackAndWithdraw> cashback;
  ReportCashback({
    required this.id,
    required this.name,
    required this.logo,
    required this.address,
    required this.waymark,
    required this.percent,
    required this.categoryShopId,
    required this.companyId,
    required this.amount,
    required this.withdrawSum,
    required this.cashbackSum,
    required this.withdraw,
    required this.cashback,
  });

  /// Generate Class from Map<String, Object?>
  factory ReportCashback.fromJson(Map<String, Object?> json) =>
      _$ReportCashbackFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ReportCashbackToJson(this);
}

@JsonSerializable()
class InlineCashbackAndWithdraw {
  final String type;
  @JsonKey(name: 'company_name')
  final String companyName;
  @JsonKey(name: 'company_logo')
  final String? companyLogo;
  @JsonKey(name: 'seller_id')
  final int sellerId;
  @JsonKey(name: 'seller_name')
  final String sellerName;
  @JsonKey(name: 'seller_phone')
  final String sellerPhone;
  @JsonKey(name: 'seller_type')
  final String sellerType;
  @JsonKey(name: 'shop_id')
  final int shopId;
  @JsonKey(name: 'shop_name')
  final String shopName;
  @JsonKey(name: 'shop_logo')
  final String? shopLogo;
  final String? percent;
  @JsonKey(name: 'total_price')
  final String? totalPrice;
  @JsonKey(name: 'client_id')
  final int clientId;
  @JsonKey(name: 'client')
  final String clientName;
  @JsonKey(name: 'client_phone')
  final String clientPhone;
  final dynamic amount;
  final String date;
  InlineCashbackAndWithdraw({
    required this.type,
    required this.companyName,
    this.companyLogo,
    required this.sellerId,
    required this.sellerName,
    required this.sellerPhone,
    required this.sellerType,
    required this.shopId,
    required this.shopName,
    this.shopLogo,
    this.percent,
    this.totalPrice,
    required this.clientId,
    required this.clientName,
    required this.clientPhone,
    required this.amount,
    required this.date,
  });

  /// Generate Class from Map<String, Object?>
  factory InlineCashbackAndWithdraw.fromJson(Map<String, Object?> json) =>
      _$InlineCashbackAndWithdrawFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$InlineCashbackAndWithdrawToJson(this);
}
