import 'package:json_annotation/json_annotation.dart';

part 'seller.g.dart';

@JsonSerializable()
class Seller {
  final int id;
  final String phone;
  final String nickname;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String type;

  Seller({
    required this.id,
    required this.phone,
    required this.nickname,
    required this.firstName,
    required this.lastName,
    required this.type,
  });

  /// Generate Class from Map<String, Object?>
  factory Seller.fromJson(Map<String, Object?> json) => _$SellerFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SellerToJson(this);
}
