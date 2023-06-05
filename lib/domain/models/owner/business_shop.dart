import 'package:json_annotation/json_annotation.dart';

import 'seller.dart';

part 'business_shop.g.dart';

@JsonSerializable()
class BusinessShop {
  final int id;
  final String name;
  final String? logo;
  final String address;
  final String waymark;
  final String percent;
  final dynamic amount;
  @JsonKey(name: 'category_shop_id')
  final int categoryShopId;
  @JsonKey(name: 'company_id')
  final BusinessCompanyLite businessCompanyLite;
  final List<Seller> sellers;

  BusinessShop({
    required this.id,
    required this.name,
    this.logo,
    required this.address,
    required this.waymark,
    required this.percent,
    required this.categoryShopId,
    required this.businessCompanyLite,
    required this.amount,
    required this.sellers,
  });

  /// Generate Class from Map<String, Object?>
  factory BusinessShop.fromJson(Map<String, Object?> json) =>
      _$BusinessShopFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$BusinessShopToJson(this);
}

@JsonSerializable()
class BusinessCompanyLite {
  final int id;
  final String name;
  BusinessCompanyLite({
    required this.id,
    required this.name,
  });

  /// Generate Class from Map<String, Object?>
  factory BusinessCompanyLite.fromJson(Map<String, Object?> json) =>
      _$BusinessCompanyLiteFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$BusinessCompanyLiteToJson(this);
}
