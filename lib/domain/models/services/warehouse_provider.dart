import 'package:json_annotation/json_annotation.dart';

part 'warehouse_provider.g.dart';

@JsonSerializable()
class WarehouseProvider {
  final int id;
  @JsonKey(name: 'company_id')
  final int companyId;
  final String name;
  final String email;
  final String phone;

  WarehouseProvider({
    required this.id,
    required this.companyId,
    required this.name,
    required this.email,
    required this.phone,
  });

  /// Generate Class from Map<String, Object?>
  factory WarehouseProvider.fromJson(Map<String, Object?> json) =>
      _$WarehouseProviderFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$WarehouseProviderToJson(this);
}
