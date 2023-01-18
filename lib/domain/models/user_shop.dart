import 'package:json_annotation/json_annotation.dart';

part 'user_shop.g.dart';

@JsonSerializable()
class UserShop {
  UserShop({
    required this.id,
    required this.name,
    required this.logo,
    required this.cashbackPercentage,
  });

  final int id;
  @JsonKey(name: 'name_shop')
  final String name;
  @JsonKey(name: 'brand_img')
  final String logo;
  @JsonKey(name: 'cashback_persent')
  final int cashbackPercentage;

  factory UserShop.fromJson(Map<String, Object?> json) =>
      _$UserShopFromJson(json);

  Map<String, Object?> toJson() => _$UserShopToJson(this);
}
