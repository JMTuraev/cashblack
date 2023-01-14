import 'package:json_annotation/json_annotation.dart';

part 'client_info.g.dart';

@JsonSerializable()
class ClientInfo {
  @JsonKey(name: 'full_name')
  final String fullName;
  final int price;
  final double cashback;
  final String date;
  ClientInfo({
    required this.fullName,
    required this.price,
    required this.cashback,
    required this.date,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientInfo.fromJson(Map<String, Object?> json) =>
      _$ClientInfoFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientInfoToJson(this);
}
