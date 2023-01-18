import 'package:json_annotation/json_annotation.dart';

part 'sum_stat.g.dart';

@JsonSerializable()
class SumStat {
  @JsonKey(name: 'phone')
  final String userName;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final int price;
  final double cashback;
  final String? salesman;
  final String? date;
  @JsonKey(name: 'true_false')
  final bool isWithdraw;

  SumStat({
    required this.userName,
    required this.price,
    required this.cashback,
    this.fullName,
    this.salesman,
    this.date,
    required this.isWithdraw,
  });

  factory SumStat.fromJson(Map<String, Object?> json) =>
      _$SumStatFromJson(json);

  Map<String, Object?> toJson() => _$SumStatToJson(this);
}
