import 'package:json_annotation/json_annotation.dart';

part 'one_month_statistic.g.dart';

@JsonSerializable()
class OneMonthStatistic {
  final DateTime? date;
  @JsonKey(name: 'sum_price')
  final int? price;
  @JsonKey(name: 'sum_cashback')
  final double? cashback;

  OneMonthStatistic({
    this.date,
    this.price,
    this.cashback,
  });

  /// Generate Class from Map<String, Object?>
  factory OneMonthStatistic.fromJson(Map<String, Object?> json) =>
      _$OneMonthStatisticFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$OneMonthStatisticToJson(this);
}
