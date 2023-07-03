import 'package:json_annotation/json_annotation.dart';

part 'weekly_stat.g.dart';

@JsonSerializable()
class WeeklyStat {
  final dynamic totalCashback;
  final dynamic cashback;
  final dynamic withdraw;
  final dynamic date;
  WeeklyStat({
    required this.totalCashback,
    required this.cashback,
    required this.withdraw,
    required this.date,
  });

  /// Generate Class from Map<String, Object?>
  factory WeeklyStat.fromJson(Map<String, Object?> json) =>
      _$WeeklyStatFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$WeeklyStatToJson(this);
}
