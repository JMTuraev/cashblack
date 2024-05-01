import 'package:json_annotation/json_annotation.dart';

import 'sklad_item.dart';

part 'sklad_prixod.g.dart';

@JsonSerializable()
class SkladPrixod {
  final String dateTime;
  final List<SkladItem> skladItems;

  SkladPrixod({
    required this.dateTime,
    required this.skladItems,
  });

  /// Generate Class from Map<String, Object?>
  factory SkladPrixod.fromJson(Map<String, Object?> json) =>
      _$SkladPrixodFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SkladPrixodToJson(this);
}
