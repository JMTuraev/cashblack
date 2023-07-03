import 'package:json_annotation/json_annotation.dart';

part 'notification_price.g.dart';

@JsonSerializable()
class NotificationPrice {
  final int id;
  final String type;
  final String price;
  final int? days;
  final int? month;

  NotificationPrice({
    required this.id,
    required this.type,
    required this.price,
    required this.days,
    this.month,
  });

  /// Generate Class from Map<String, Object?>
  factory NotificationPrice.fromJson(Map<String, Object?> json) =>
      _$NotificationPriceFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$NotificationPriceToJson(this);
}
