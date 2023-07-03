import 'package:json_annotation/json_annotation.dart';

part 'client_paying.g.dart';

@JsonSerializable()
class ClientPaying {
  final int id;
  @JsonKey(name: 'company_logo')
  final String? companyLogo;
  @JsonKey(name: 'company_name')
  final String companyName;
  @JsonKey(name: 'shop_id')
  final int shopId;
  @JsonKey(name: 'shop_name')
  final String shopName;
  @JsonKey(name: 'shop_logo')
  final String? shopLogo;
  @JsonKey(name: 'client_id')
  final int clientId;
  @JsonKey(name: 'seller_name')
  final String sellerName;
  @JsonKey(name: 'seller_id')
  final int sellerId;
  @JsonKey(name: 'total_price')
  final dynamic totalPrice;
  final dynamic amount;
  final String status;
  @JsonKey(name: 'created_at')
  final String createdAt;
  ClientPaying({
    required this.id,
    this.companyLogo,
    required this.companyName,
    required this.shopId,
    required this.shopName,
    this.shopLogo,
    required this.clientId,
    required this.sellerName,
    required this.sellerId,
    required this.totalPrice,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientPaying.fromJson(Map<String, Object?> json) =>
      _$ClientPayingFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientPayingToJson(this);
}
