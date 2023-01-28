import 'package:json_annotation/json_annotation.dart';

part 'client_statistics_all.g.dart';

@JsonSerializable()
class ClientStatisticsAll {
  @JsonKey(name: 'all_sum')
  final int allSum;
  @JsonKey(name: 'all_cashback')
  final double allCashback;
  @JsonKey(name: 'all_true_cashback')
  final double allTrueCashback;
  @JsonKey(name: 'all_seperate_cashback')
  final double allSeperateCashback;

  ClientStatisticsAll({
    required this.allSum,
    required this.allCashback,
    required this.allTrueCashback,
    required this.allSeperateCashback,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientStatisticsAll.fromJson(Map<String, Object?> json) =>
      _$ClientStatisticsAllFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientStatisticsAllToJson(this);
}
