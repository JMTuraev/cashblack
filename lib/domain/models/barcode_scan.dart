// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'barcode_scan.g.dart';

@JsonSerializable()
class BarcodeScan {
  @JsonKey(name: 'data')
  final List<Datum> datum;
  final double cashback;

  BarcodeScan({
    required this.datum,
    required this.cashback,
  });

  /// Generate Class from Map<String, Object?>
  factory BarcodeScan.fromJson(Map<String, Object?> json) =>
      _$BarcodeScanFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$BarcodeScanToJson(this);
}
