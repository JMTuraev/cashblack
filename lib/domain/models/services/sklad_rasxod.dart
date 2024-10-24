// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'warehouse_rasxod_create.dart';

class SkladRasxod {
  final String dateTime;
  final List<WarehouseRasxodCreate> rasxodItems;

  SkladRasxod({
    required this.dateTime,
    required this.rasxodItems,
  });

  SkladRasxod copyWith({
    String? dateTime,
    List<WarehouseRasxodCreate>? rasxodItems,
  }) {
    return SkladRasxod(
      dateTime: dateTime ?? this.dateTime,
      rasxodItems: rasxodItems ?? this.rasxodItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime,
      'rasxodItems': rasxodItems.map((x) => x.toMap()).toList(),
    };
  }

  factory SkladRasxod.fromMap(Map<String, dynamic> map) {
    return SkladRasxod(
      dateTime: map['dateTime'] as String,
      rasxodItems: List<WarehouseRasxodCreate>.from(
        (map['rasxodItems'] as List<int>).map<WarehouseRasxodCreate>(
          (x) => WarehouseRasxodCreate.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SkladRasxod.fromJson(String source) =>
      SkladRasxod.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SkladRasxod(dateTime: $dateTime, rasxodItems: $rasxodItems)';

  @override
  bool operator ==(covariant SkladRasxod other) {
    if (identical(this, other)) return true;

    return other.dateTime == dateTime &&
        listEquals(other.rasxodItems, rasxodItems);
  }

  @override
  int get hashCode => dateTime.hashCode ^ rasxodItems.hashCode;
}
