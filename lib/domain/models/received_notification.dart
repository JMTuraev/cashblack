import 'package:json_annotation/json_annotation.dart';

part 'received_notification.g.dart';

@JsonSerializable()
class ReceivedNotification {
  final String title;
  final int id;
  final String content;
  @JsonKey(name: 'img')
  final String image;
  @JsonKey(name: 'name_shops')
  final String name;
  final String date;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.name,
    required this.date,
  });

  factory ReceivedNotification.fromJson(Map<String, Object?> json) =>
      _$ReceivedNotificationFromJson(json);

  Map<String, Object?> toJson() => _$ReceivedNotificationToJson(this);
}
