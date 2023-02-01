import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  final int id;
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'username')
  final String userName;

  Datum({
    required this.id,
    required this.fullName,
    required this.userName,
  });

  /// Generate Class from Map<String, Object?>
  factory Datum.fromJson(Map<String, Object?> json) => _$DatumFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$DatumToJson(this);
}
