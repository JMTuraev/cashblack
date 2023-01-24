// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      userName: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      shops: (json['shops_id'] as List<dynamic>)
          .map((e) => Shop.fromJson(e as Map<String, dynamic>))
          .toList(),
      barcode: json['barcode_id'] as String?,
      barcodeImage: json['barcode'] as String?,
      groups: (json['groups'] as List<dynamic>)
          .map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.userName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'shops_id': instance.shops,
      'groups': instance.groups,
      'barcode_id': instance.barcode,
      'barcode': instance.barcodeImage,
    };
