import 'package:json_annotation/json_annotation.dart';

import 'group.dart';
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

  final List<Group> groups;

  @JsonKey(name: 'barcode_id')
  final String? barcode;
  @JsonKey(name: 'barcode')
  final String? barcodeImage;
  @JsonKey(name: 'is_switcher')
  final bool isFreezed;

  User({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.shops,
    this.barcode,
    this.barcodeImage,
    required this.groups,
    required this.isFreezed,
  });

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  Map<String, Object?> toJson() => _$UserToJson(this);
}
