// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_prixod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehousePrixod _$WarehousePrixodFromJson(Map<String, dynamic> json) =>
    WarehousePrixod(
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: Links.fromJson(json['links'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WarehousePrixodToJson(WarehousePrixod instance) =>
    <String, dynamic>{
      'data': instance.data,
      'links': instance.links,
      'meta': instance.meta,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as int,
      number: json['number'] as String,
      createdDate: json['date_at'] as String,
      total: json['total'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'date_at': instance.createdDate,
      'total': instance.total,
      'products': instance.products,
    };

ProductElement _$ProductElementFromJson(Map<String, dynamic> json) =>
    ProductElement(
      id: json['id'] as int,
      product: ProductProduct.fromJson(json['product'] as Map<String, dynamic>),
      warehouse:
          WarehouseInner.fromJson(json['warehouse'] as Map<String, dynamic>),
      invoiceQty: json['invoice_qty'] as int,
      unit: WarehouseUnit.fromJson(json['unit'] as Map<String, dynamic>),
      incomeQty: json['income_qty'] as int,
      qty: json['qty'] as int,
      price: json['price'] as String,
      sellPrice: json['sell_price'] as String,
    );

Map<String, dynamic> _$ProductElementToJson(ProductElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'warehouse': instance.warehouse,
      'invoice_qty': instance.invoiceQty,
      'unit': instance.unit,
      'income_qty': instance.incomeQty,
      'qty': instance.qty,
      'price': instance.price,
      'sell_price': instance.sellPrice,
    };

ProductProduct _$ProductProductFromJson(Map<String, dynamic> json) =>
    ProductProduct(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as int,
      barCode: json['bar_code'] as String,
    );

Map<String, dynamic> _$ProductProductToJson(ProductProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'bar_code': instance.barCode,
    };

WarehouseInner _$WarehouseInnerFromJson(Map<String, dynamic> json) =>
    WarehouseInner(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$WarehouseInnerToJson(WarehouseInner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      first: json['first'] as String,
      last: json['last'] as String,
      prev: json['prev'],
      next: json['next'],
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      currentPage: json['current_page'] as int,
      from: json['from'] as int,
      lastPage: json['last_page'] as int,
      links: (json['links'] as List<dynamic>)
          .map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      to: json['to'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'from': instance.from,
      'last_page': instance.lastPage,
      'links': instance.links,
      'path': instance.path,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      url: json['url'],
      label: json['label'] as String,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
