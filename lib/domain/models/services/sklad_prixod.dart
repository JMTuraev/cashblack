// ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'warehouse_item.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'warehouse_prixod_create.dart';

// part 'sklad_prixod.g.dart';

class SkladPrixod {
  final String dateTime;
  final List<WarehousePrixodCreate> skladItems;

  SkladPrixod({
    required this.dateTime,
    required this.skladItems,
  });

  SkladPrixod copyWith({
    String? dateTime,
    List<WarehousePrixodCreate>? skladItems,
  }) {
    return SkladPrixod(
      dateTime: dateTime ?? this.dateTime,
      skladItems: skladItems ?? this.skladItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime,
      'skladItems': skladItems.map((x) => x.toJson()).toList(),
    };
  }

  factory SkladPrixod.fromMap(Map<String, dynamic> map) {
    return SkladPrixod(
      dateTime: map['dateTime'] as String,
      skladItems: List<WarehousePrixodCreate>.from(
        (map['skladItems'] as List<int>).map<WarehousePrixodCreate>(
          (x) => WarehousePrixodCreate.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SkladPrixod.fromJson(String source) =>
      SkladPrixod.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SkladPrixod(dateTime: $dateTime, skladItems: $skladItems)';

  @override
  bool operator ==(covariant SkladPrixod other) {
    if (identical(this, other)) return true;

    return other.dateTime == dateTime &&
        listEquals(other.skladItems, skladItems);
  }

  @override
  int get hashCode => dateTime.hashCode ^ skladItems.hashCode;
}
