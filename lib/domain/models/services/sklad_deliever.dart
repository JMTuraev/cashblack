import 'package:json_annotation/json_annotation.dart';

part 'sklad_deliever.g.dart';

@JsonSerializable()
class SkladDeliever {
  final String value;
  final String name;

  SkladDeliever({
    required this.value,
    required this.name,
  });

  /// Generate Class from Map<String, Object?>
  factory SkladDeliever.fromJson(Map<String, Object?> json) =>
      _$SkladDelieverFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SkladDelieverToJson(this);
}
