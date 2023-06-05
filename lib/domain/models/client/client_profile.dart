import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_profile.g.dart';

@JsonSerializable()
class ClientProfile extends ChangeNotifier {
  final int id;
  final String phone;
  final String nickname;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'district_id')
  final String? districtId;
  final String total;
  final String balance;
  final String withdraw;
  final String amount;
  final String type;
  ClientProfile({
    required this.id,
    required this.phone,
    required this.nickname,
    required this.firstName,
    required this.lastName,
    this.districtId,
    required this.total,
    required this.balance,
    required this.withdraw,
    required this.amount,
    required this.type,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientProfile.fromJson(Map<String, Object?> json) =>
      _$ClientProfileFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientProfileToJson(this);
}
