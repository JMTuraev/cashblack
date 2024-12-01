// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'warehouse_category.dart';
import 'warehouse_unit.dart';

class WarehouseItemForKassa {
  final int id;
  final String name;
  final WarehouseUnit unit;
  final WarehouseCategory category;
  @JsonKey(name: 'bar_code')
  final String barCode;
  final int code;
  int count;
  double price;
  double addition;
  double totalPrice;
  final List<String> tags;
  WarehouseItemForKassa({
    required this.id,
    required this.name,
    required this.unit,
    required this.category,
    required this.barCode,
    required this.code,
    required this.count,
    required this.price,
    required this.addition,
    required this.totalPrice,
    required this.tags,
  });

  WarehouseItemForKassa copyWith({
    int? id,
    String? name,
    WarehouseUnit? unit,
    WarehouseCategory? category,
    String? barCode,
    int? code,
    int? count,
    double? price,
    double? addition,
    double? totalPrice,
    List<String>? tags,
  }) {
    return WarehouseItemForKassa(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      barCode: barCode ?? this.barCode,
      code: code ?? this.code,
      count: count ?? this.count,
      price: price ?? this.price,
      addition: addition ?? this.addition,
      totalPrice: totalPrice ?? this.totalPrice,
      tags: tags ?? this.tags,
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
      'count': count,
      'price': price,
      'addition': addition,
      'totalPrice': totalPrice,
      'tags': tags,
    };
  }

  factory WarehouseItemForKassa.fromMap(Map<String, dynamic> map) {
    return WarehouseItemForKassa(
      id: map['id'] as int,
      name: map['name'] as String,
      unit: WarehouseUnit.fromJson(map['unit'] as Map<String, dynamic>),
      category:
          WarehouseCategory.fromJson(map['category'] as Map<String, dynamic>),
      barCode: map['barCode'] as String,
      code: map['code'] as int,
      count: map['count'] as int,
      price: map['price'] as double,
      addition: map['addition'] as double,
      totalPrice: map['totalPrice'] as double,
      tags: List<String>.from(
        map['tags'] as List<String>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WarehouseItemForKassa.fromJson(String source) =>
      WarehouseItemForKassa.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'WarehouseItemForKassa(id: $id, name: $name, unit: $unit, category: $category, barCode: $barCode, code: $code, count: $count, price: $price, addition: $addition, totalPrice: $totalPrice, tags: $tags)';
  }

  @override
  bool operator ==(covariant WarehouseItemForKassa other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.unit == unit &&
        other.category == category &&
        other.barCode == barCode &&
        other.code == code &&
        other.count == count &&
        other.price == price &&
        other.addition == addition &&
        other.totalPrice == totalPrice &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        unit.hashCode ^
        category.hashCode ^
        barCode.hashCode ^
        code.hashCode ^
        count.hashCode ^
        price.hashCode ^
        addition.hashCode ^
        totalPrice.hashCode ^
        tags.hashCode;
  }
}
