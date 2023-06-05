import 'package:json_annotation/json_annotation.dart';

import '../common/district.dart';

part 'business_company.g.dart';

@JsonSerializable()
class BusinessCompany {
  final int id;
  final String name;
  final String logo;
  final String inn;
  final String address;
  @JsonKey(name: 'p_seria')
  final String passwordId;
  final String pinfl;
  final District district;
  BusinessCompany({
    required this.id,
    required this.name,
    required this.logo,
    required this.inn,
    required this.address,
    required this.passwordId,
    required this.pinfl,
    required this.district,
  });

  /// Generate Class from Map<String, Object?>
  factory BusinessCompany.fromJson(Map<String, Object?> json) =>
      _$BusinessCompanyFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$BusinessCompanyToJson(this);
}
