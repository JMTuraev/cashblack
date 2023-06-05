import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'business_license.dart';

part 'business_profile.g.dart';

@JsonSerializable()
class BusinessProfile extends ChangeNotifier {
  final int id;
  final String phone;
  final String nickname;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'district_id')
  final String? districtId;
  // final int balance;
  @JsonKey(name: 'total_amount')
  final String totalAmount;
  @JsonKey(name: 'total_expense')
  final String totalExpense;
  final String type;
  final List<BusinessLicense> licence;

  BusinessProfile({
    required this.id,
    required this.phone,
    required this.nickname,
    required this.firstName,
    required this.lastName,
    this.districtId,
    // required this.balance,
    required this.totalAmount,
    required this.totalExpense,
    required this.type,
    required this.licence,
  });

  /// Generate Class from Map<String, Object?>
  factory BusinessProfile.fromJson(Map<String, Object?> json) =>
      _$BusinessProfileFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$BusinessProfileToJson(this);
}
