import 'package:json_annotation/json_annotation.dart';

part 'bonus_price.g.dart';

@JsonSerializable()
class BonusPrice {
  final int id;
  final String amount;
  final String bonus;
  BonusPrice({
    required this.id,
    required this.amount,
    required this.bonus,
  });

  /// Generate Class from Map<String, Object?>
  factory BonusPrice.fromJson(Map<String, Object?> json) =>
      _$BonusPriceFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$BonusPriceToJson(this);
}
