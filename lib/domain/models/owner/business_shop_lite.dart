import 'package:json_annotation/json_annotation.dart';

part 'business_shop_lite.g.dart';

@JsonSerializable()
class BusinessShopLite {
  final int id;
  final String name;
  BusinessShopLite({
    required this.id,
    required this.name,
  });

  /// Generate Class from Map<String, Object?>
  factory BusinessShopLite.fromJson(Map<String, Object?> json) =>
      _$BusinessShopLiteFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$BusinessShopLiteToJson(this);
}
