// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'warehouse_category.dart';
import 'warehouse_unit.dart';

class WarehouseItem {
  final int id;
  final String name;
  final WarehouseUnit unit;
  final WarehouseCategory category;
// "user": {
//     "id": 121,
//     "name": "Owner Master"
// },
// "company": {
//     "id": 20,
//     "name": "Demo Company"
// },
// "category": {
//     "id": 2,
//     "name": "mebel"
// },
  @JsonKey(name: 'bar_code')
  final String barCode;
  final int code;
  final int lower;

  WarehouseItem({
    required this.id,
    required this.name,
    required this.unit,
    required this.category,
    required this.barCode,
    required this.code,
    required this.lower,
  });

  WarehouseItem copyWith({
    int? id,
    String? name,
    WarehouseUnit? unit,
    WarehouseCategory? category,
    String? barCode,
    int? code,
    int? lower,
  }) {
    return WarehouseItem(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      barCode: barCode ?? this.barCode,
      code: code ?? this.code,
      lower: lower ?? this.lower,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'unit': unit.toJson(),
      'category': category.toJson(),
      'barCode': barCode,
      'code': code,
      'lower': lower,
    };
  }

  factory WarehouseItem.fromMap(Map<String, dynamic> map) {
    return WarehouseItem(
      id: map['id'] as int,
      name: map['name'] as String,
      unit: WarehouseUnit.fromJson(map['unit'] as Map<String, dynamic>),
      category:
          WarehouseCategory.fromJson(map['category'] as Map<String, dynamic>),
      barCode: map['barCode'] as String,
      code: map['code'] as int,
      lower: map['lower'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WarehouseItem.fromJson(String source) =>
      WarehouseItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WarehouseItem(id: $id, name: $name, unit: $unit, category: $category, barCode: $barCode, code: $code, lower: $lower)';
  }

  @override
  bool operator ==(covariant WarehouseItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.unit == unit &&
        other.category == category &&
        other.barCode == barCode &&
        other.code == code &&
        other.lower == lower;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        unit.hashCode ^
        category.hashCode ^
        barCode.hashCode ^
        code.hashCode ^
        lower.hashCode;
  }
}
