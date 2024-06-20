import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'business_shop_lite.dart';

part 'seller_profile.g.dart';

@JsonSerializable()
class SellerProfile extends ChangeNotifier {
  final int id;
  final String phone;
  final String nickname;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'district_id')
  final String? districtId;
  final BusinessShopLite shop;
  final String type;
  final int status;

  SellerProfile({
    required this.id,
    required this.phone,
    required this.nickname,
    required this.firstName,
    required this.lastName,
    this.districtId,
    required this.shop,
    required this.type,
    required this.status,
  });

  /// Generate Class from Map<String, Object?>
  factory SellerProfile.fromJson(Map<String, Object?> json) =>
      _$SellerProfileFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SellerProfileToJson(this);
}
