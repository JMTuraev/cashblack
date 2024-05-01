import 'package:json_annotation/json_annotation.dart';

part 'sklad_item_status.g.dart';

@JsonSerializable()
class SkladItemStatus {
  final String value;
  final String name;

  SkladItemStatus({
    required this.value,
    required this.name,
  });

  /// Generate Class from Map<String, Object?>
  factory SkladItemStatus.fromJson(Map<String, Object?> json) =>
      _$SkladItemStatusFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SkladItemStatusToJson(this);
}
