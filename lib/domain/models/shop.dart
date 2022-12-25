import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'city.dart';

part 'shop.g.dart';

@JsonSerializable()
class Shop {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'name_shops')
  final String name;
  final int cashback;
  @JsonKey(name: 'categor_id')
  final Category category;
  @JsonKey(name: 'provinse_id')
  final Province province;
  @JsonKey(name: 'distrik_id')
  final City city;
  Shop({
    required this.id,
    required this.userId,
    required this.name,
    required this.cashback,
    required this.category,
    required this.province,
    required this.city,
  });

  factory Shop.fromJson(Map<String, Object?> json) => _$ShopFromJson(json);

  Map<String, Object?> toJson() => _$ShopToJson(this);
}
