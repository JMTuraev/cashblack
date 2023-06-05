import 'package:json_annotation/json_annotation.dart';

part 'business_license.g.dart';

@JsonSerializable()
class BusinessLicense {
  @JsonKey(name: 'price_id')
  final BusinessLicensePrice price;
  final String amount;
  @JsonKey(name: 'start_at')
  final String startAt;
  @JsonKey(name: 'end_at')
  final String endAt;
  @JsonKey(name: 'created_at')
  final String createdAt;

  BusinessLicense({
    required this.price,
    required this.amount,
    required this.startAt,
    required this.endAt,
    required this.createdAt,
  });

  /// Generate Class from Map<String, Object?>
  factory BusinessLicense.fromJson(Map<String, Object?> json) =>
      _$BusinessLicenseFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$BusinessLicenseToJson(this);
}

@JsonSerializable()
class BusinessLicensePrice {
  final int id;
  final String type;
  final String price;
  final int? days;
  final int month;

  BusinessLicensePrice({
    required this.id,
    required this.type,
    required this.price,
    this.days,
    required this.month,
  });

  /// Generate Class from Map<String, Object?>
  factory BusinessLicensePrice.fromJson(Map<String, Object?> json) =>
      _$BusinessLicensePriceFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$BusinessLicensePriceToJson(this);
}
