import 'package:json_annotation/json_annotation.dart';

import 'shop_notification.dart';

part 'sent_notification.g.dart';

@JsonSerializable()
class SentNotification {
  @JsonKey(name: 'shop_id')
  final ShopNotification shop;
  final String title;
  final String content;
  @JsonKey(name: 'img')
  final String image;
  @JsonKey(name: 'status_id')
  final int status;
  final String date;
  @JsonKey(name: 'payment_summ')
  dynamic? payment;
  SentNotification({
    required this.shop,
    required this.title,
    required this.content,
    required this.image,
    required this.status,
    required this.date,
    this.payment,
  });
  // final String user_id;

  /// Generate Class from Map<String, Object?>
  factory SentNotification.fromJson(Map<String, Object?> json) =>
      _$SentNotificationFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$SentNotificationToJson(this);
}
