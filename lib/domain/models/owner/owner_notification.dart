import 'package:json_annotation/json_annotation.dart';

import 'business_shop.dart';

part 'owner_notification.g.dart';

@JsonSerializable()
class OwnerNotification {
  final int id;
  final String type;
  final String title;
  final String text;
  final String? image;
  @JsonKey(name: 'end_at')
  final String endAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'admin_id')
  final dynamic adminId;
  final String status;
  final dynamic remark;
  //1,true : 0,false
  final dynamic showed;
  @JsonKey(name: 'showed_count')
  final int showedCount;
  //1,true : 0,false
  final dynamic like;
  @JsonKey(name: 'like_count')
  final int likeCount;
  final BusinessShop? shop;
  OwnerNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.text,
    required this.image,
    required this.endAt,
    required this.updatedAt,
    required this.adminId,
    required this.status,
    required this.remark,
    required this.showed,
    required this.showedCount,
    required this.like,
    required this.likeCount,
    required this.shop,
  });

  /// Generate Class from Map<String, Object?>
  factory OwnerNotification.fromJson(Map<String, Object?> json) =>
      _$OwnerNotificationFromJson(json);

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => _$OwnerNotificationToJson(this);
}
