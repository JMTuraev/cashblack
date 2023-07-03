import 'package:json_annotation/json_annotation.dart';

part 'client_cashback.g.dart';

@JsonSerializable()
class ClientCashback {
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
  final String percent;
  @JsonKey(name: 'total_price')
  final dynamic totalPrice;
  final dynamic amount;
  final String date;
  ClientCashback({
    required this.companyName,
    required this.companyLogo,
    required this.sellerId,
    required this.sellerName,
    required this.sellerPhone,
    required this.sellerType,
    required this.shopId,
    required this.shopName,
    required this.shopLogo,
    required this.percent,
    required this.totalPrice,
    required this.amount,
    required this.date,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientCashback.fromJson(Map<String, Object?> json) =>
      _$ClientCashbackFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientCashbackToJson(this);
}
