import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../owner/business_license.dart';
import '../owner/business_shop.dart';

part 'seller_owner_profile.g.dart';

@JsonSerializable()
class SellerOwnerProfile extends ChangeNotifier {
  final int id;
  final String phone;
  final String nickname;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'district_id')
  final String? districtId;
  final dynamic balance;
  final dynamic total;
  final dynamic withdraw;
  final dynamic amount;
  // final String type;
  final int status;
  final List<BusinessLicense> licence;
  @JsonKey(name: 'shop_id')
  final BusinessShop shop;
  SellerOwnerProfile({
    required this.id,
    required this.phone,
    required this.nickname,
    required this.firstName,
    required this.lastName,
    this.districtId,
    required this.balance,
    required this.total,
    required this.withdraw,
    required this.amount,
    // required this.type,
    required this.licence,
    required this.shop,
    required this.status,
  });

  /// Generate Class from Map<String, Object?>
  factory SellerOwnerProfile.fromJson(Map<String, Object?> json) =>
      _$SellerOwnerProfileFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SellerOwnerProfileToJson(this);
}
