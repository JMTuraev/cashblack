import 'package:json_annotation/json_annotation.dart';

import 'shop.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  @JsonKey(name: 'username')
  final String userName;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'shops_id')
  final List<Shop> shops;

  @JsonKey(name: 'barcode_id')
  final String barcode;
  @JsonKey(name: 'barcode')
  final String barcodeImage;

  User({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.shops,
    required this.barcode,
    required this.barcodeImage,
  });

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  Map<String, Object?> toJson() => _$UserToJson(this);
}
