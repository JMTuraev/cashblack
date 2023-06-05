import 'package:json_annotation/json_annotation.dart';

part 'sum_cashback.g.dart';

@JsonSerializable()
class SumCashback {
  final String name;
  final String phone;
  @JsonKey(name: 'sums')
  final int sum;
  @JsonKey(name: 'cashbak')
  final double cashback;

  SumCashback({
    required this.name,
    required this.phone,
    required this.sum,
    required this.cashback,
  });

  factory SumCashback.fromJson(Map<String, Object?> json) =>
      _$SumCashbackFromJson(json);

  Map<String, Object?> toJson() => _$SumCashbackToJson(this);
}
