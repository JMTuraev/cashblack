import 'package:json_annotation/json_annotation.dart';

import 'client_info.dart';

part 'client_statistics.g.dart';

@JsonSerializable()
class ClientStatistics {
  @JsonKey(name: 'all_sum')
  final int allSum;
  @JsonKey(name: 'all_cashback')
  final double allCashback;
  @JsonKey(name: 'all_true_cashback')
  final double allTrueCashback;
  @JsonKey(name: 'all_seperate_cashback')
  final double allSeperateCashback;

  @JsonKey(name: 'client_info')
  final List<ClientInfo> clientInfo;

  ClientStatistics({
    required this.allSum,
    required this.allCashback,
    required this.allTrueCashback,
    required this.allSeperateCashback,
    required this.clientInfo,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientStatistics.fromJson(Map<String, Object?> json) =>
      _$ClientStatisticsFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientStatisticsToJson(this);
}
