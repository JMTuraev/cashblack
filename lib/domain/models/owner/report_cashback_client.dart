import 'package:json_annotation/json_annotation.dart';

part 'report_cashback_client.g.dart';

@JsonSerializable()
class ReportCashbackClient {
  final int id;
  final String name;
  final String phone;
  final dynamic totalCashback;
  final dynamic cashback;
  final dynamic withdraw;
  ReportCashbackClient({
    required this.id,
    required this.name,
    required this.phone,
    required this.totalCashback,
    required this.cashback,
    required this.withdraw,
  });
// final String sum;

  /// Generate Class from Map<String, Object?>
  factory ReportCashbackClient.fromJson(Map<String, Object?> json) =>
      _$ReportCashbackClientFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ReportCashbackClientToJson(this);
}
