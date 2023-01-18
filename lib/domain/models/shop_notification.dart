import 'package:json_annotation/json_annotation.dart';

part 'shop_notification.g.dart';

@JsonSerializable()
class ShopNotification {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'name_shops')
  final String name;
  @JsonKey(name: 'brand_img')
  final String? image;
  final int cashback;
  @JsonKey(name: 'categor_id')
  final int category;
  @JsonKey(name: 'provinse_id')
  final int province;
  @JsonKey(name: 'distrik_id')
  final int city;
  ShopNotification({
    required this.id,
    required this.userId,
    required this.name,
    required this.cashback,
    required this.category,
    required this.province,
    required this.city,
    this.image,
  });

  /// Generate Class from Map<String, Object?>
  factory ShopNotification.fromJson(Map<String, Object?> json) =>
      _$ShopNotificationFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ShopNotificationToJson(this);
}
