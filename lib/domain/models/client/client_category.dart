import 'package:json_annotation/json_annotation.dart';

import 'client_shop.dart';

part 'client_category.g.dart';

@JsonSerializable()
class ClientCategory {
  final int id;
  final String name;
  final String title;
  final dynamic logo;
  @JsonKey(name: 'shop_count')
  final int count;
  final List<ClientShop> shops;
  ClientCategory({
    required this.id,
    required this.name,
    required this.title,
    required this.logo,
    required this.count,
    required this.shops,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientCategory.fromJson(Map<String, Object?> json) =>
      _$ClientCategoryFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientCategoryToJson(this);
}
