import 'package:json_annotation/json_annotation.dart';

import 'owner_notification.dart';

part 'client_notification.g.dart';

@JsonSerializable()
class ClientNotification {
  final int count;
  @JsonKey(name: 'data')
  final List<OwnerNotification> notifications;
  ClientNotification({
    required this.count,
    required this.notifications,
  });

  /// Generate Class from Map<String, Object?>
  factory ClientNotification.fromJson(Map<String, Object?> json) =>
      _$ClientNotificationFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$ClientNotificationToJson(this);
}
