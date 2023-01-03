import 'package:json_annotation/json_annotation.dart';

part 'sum_stat.g.dart';

@JsonSerializable()
class SumStat {
  @JsonKey(name: 'phone')
  final String userName;
  final String price;
  final double cashback;
  final String? salesman;
  final String date;

  SumStat({
    required this.userName,
    required this.price,
    required this.cashback,
    this.salesman,
    required this.date,
  });

  factory SumStat.fromJson(Map<String, Object?> json) =>
      _$SumStatFromJson(json);

  Map<String, Object?> toJson() => _$SumStatToJson(this);
}
