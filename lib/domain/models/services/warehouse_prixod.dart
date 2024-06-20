import 'package:json_annotation/json_annotation.dart';

import 'warehouse_unit.dart';

part 'warehouse_prixod.g.dart';

@JsonSerializable()
class WarehousePrixod {
  @JsonKey(name: 'data')
  final List<Datum> data;
  @JsonKey(name: 'links')
  final Links links;
  @JsonKey(name: 'meta')
  final Meta meta;

  WarehousePrixod({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory WarehousePrixod.fromJson(Map<String, dynamic> json) =>
      _$WarehousePrixodFromJson(json);

  Map<String, dynamic> toJson() => _$WarehousePrixodToJson(this);
}

@JsonSerializable()
class Datum {
  final int id;
  // final User user;
  // final Company company;
  final String number;
  @JsonKey(name: 'date_at')
  final String createdDate;
  final String total;
  @JsonKey(name: 'products')
  final List<ProductElement> products;

  Datum({
    required this.id,
    // required this.user,
    // required this.company,
    required this.number,
    required this.createdDate,
    required this.total,
    required this.products,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

// @JsonSerializable()
// class Company {
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'name')
//   final String name;
//   @JsonKey(name: 'logo')
//   final dynamic logo;
//   @JsonKey(name: 'inn')
//   final String inn;
//   @JsonKey(name: 'address')
//   final String address;
//   @JsonKey(name: 'p_seria')
//   final String pSeria;
//   @JsonKey(name: 'pinfl')
//   final String pinfl;
//   @JsonKey(name: 'district')
//   final District district;

//   Company({
//     required this.id,
//     required this.name,
//     required this.logo,
//     required this.inn,
//     required this.address,
//     required this.pSeria,
//     required this.pinfl,
//     required this.district,
//   });

//   factory Company.fromJson(Map<String, dynamic> json) =>
//       _$CompanyFromJson(json);

//   Map<String, dynamic> toJson() => _$CompanyToJson(this);
// }

// @JsonSerializable()
// class District {
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'name_uz')
//   final String nameUz;
//   @JsonKey(name: 'name_oz')
//   final String nameOz;
//   @JsonKey(name: 'name_ru')
//   final String nameRu;
//   @JsonKey(name: 'province')
//   final Province province;

//   District({
//     required this.id,
//     required this.nameUz,
//     required this.nameOz,
//     required this.nameRu,
//     required this.province,
//   });

//   factory District.fromJson(Map<String, dynamic> json) =>
//       _$DistrictFromJson(json);

//   Map<String, dynamic> toJson() => _$DistrictToJson(this);
// }

// @JsonSerializable()
// class Province {
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'name_uz')
//   final String nameUz;
//   @JsonKey(name: 'name_oz')
//   final String nameOz;
//   @JsonKey(name: 'name_ru')
//   final String nameRu;

//   Province({
//     required this.id,
//     required this.nameUz,
//     required this.nameOz,
//     required this.nameRu,
//   });

//   factory Province.fromJson(Map<String, dynamic> json) =>
//       _$ProvinceFromJson(json);

//   Map<String, dynamic> toJson() => _$ProvinceToJson(this);
// }

@JsonSerializable()
class ProductElement {
  final int id;
  final ProductProduct product;
  final WarehouseInner warehouse;
  @JsonKey(name: 'invoice_qty')
  final int invoiceQty;
  final WarehouseUnit unit;
  @JsonKey(name: 'income_qty')
  final int incomeQty;
  final int qty;
  final String price;
  @JsonKey(name: 'sell_price')
  final String sellPrice;

  ProductElement({
    required this.id,
    required this.product,
    required this.warehouse,
    required this.invoiceQty,
    required this.unit,
    required this.incomeQty,
    required this.qty,
    required this.price,
    required this.sellPrice,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) =>
      _$ProductElementFromJson(json);

  Map<String, dynamic> toJson() => _$ProductElementToJson(this);
}

@JsonSerializable()
class ProductProduct {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'code')
  final int code;
  @JsonKey(name: 'bar_code')
  final String barCode;

  ProductProduct({
    required this.id,
    required this.name,
    required this.code,
    required this.barCode,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) =>
      _$ProductProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductProductToJson(this);
}

// @JsonSerializable()
// class Unit {
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'name')
//   final String name;
//   @JsonKey(name: 'title')
//   final String title;

//   Unit({
//     required this.id,
//     required this.name,
//     required this.title,
//   });

//   factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

//   Map<String, dynamic> toJson() => _$UnitToJson(this);
// }

@JsonSerializable()
class WarehouseInner {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;

  WarehouseInner({
    required this.id,
    required this.name,
  });

  factory WarehouseInner.fromJson(Map<String, dynamic> json) =>
      _$WarehouseInnerFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseInnerToJson(this);
}

// @JsonSerializable()
// class User {
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'phone')
//   final String phone;
//   @JsonKey(name: 'nickname')
//   final String nickname;
//   @JsonKey(name: 'first_name')
//   final String firstName;
//   @JsonKey(name: 'last_name')
//   final String lastName;
//   @JsonKey(name: 'district_id')
//   final dynamic districtId;
//   @JsonKey(name: 'shop_id')
//   final ShopId shopId;
//   @JsonKey(name: 'type')
//   final String type;
//   @JsonKey(name: 'status')
//   final int status;

//   User({
//     required this.id,
//     required this.phone,
//     required this.nickname,
//     required this.firstName,
//     required this.lastName,
//     required this.districtId,
//     required this.shopId,
//     required this.type,
//     required this.status,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }

// @JsonSerializable()
// class ShopId {
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'name')
//   final String name;
//   @JsonKey(name: 'logo')
//   final String logo;
//   @JsonKey(name: 'address')
//   final String address;
//   @JsonKey(name: 'waymark')
//   final String waymark;
//   @JsonKey(name: 'percent')
//   final String percent;
//   @JsonKey(name: 'category_shop_id')
//   final int categoryShopId;
//   @JsonKey(name: 'company_id')
//   final Warehouse companyId;
//   @JsonKey(name: 'district_id')
//   final District districtId;
//   @JsonKey(name: 'amount')
//   final int amount;
//   @JsonKey(name: 'sellers')
//   final List<Seller> sellers;

//   ShopId({
//     required this.id,
//     required this.name,
//     required this.logo,
//     required this.address,
//     required this.waymark,
//     required this.percent,
//     required this.categoryShopId,
//     required this.companyId,
//     required this.districtId,
//     required this.amount,
//     required this.sellers,
//   });

//   factory ShopId.fromJson(Map<String, dynamic> json) => _$ShopIdFromJson(json);

//   Map<String, dynamic> toJson() => _$ShopIdToJson(this);
// }

// @JsonSerializable()
// class Seller {
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'phone')
//   final String phone;
//   @JsonKey(name: 'nickname')
//   final String nickname;
//   @JsonKey(name: 'first_name')
//   final String firstName;
//   @JsonKey(name: 'last_name')
//   final String lastName;
//   @JsonKey(name: 'type')
//   final String type;

//   Seller({
//     required this.id,
//     required this.phone,
//     required this.nickname,
//     required this.firstName,
//     required this.lastName,
//     required this.type,
//   });

//   factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);

//   Map<String, dynamic> toJson() => _$SellerToJson(this);
// }

@JsonSerializable()
class Links {
  @JsonKey(name: 'first')
  final String first;
  @JsonKey(name: 'last')
  final String last;
  @JsonKey(name: 'prev')
  final dynamic prev;
  @JsonKey(name: 'next')
  final dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'from')
  final int from;
  @JsonKey(name: 'last_page')
  final int lastPage;
  @JsonKey(name: 'links')
  final List<Link> links;
  @JsonKey(name: 'path')
  final String path;
  @JsonKey(name: 'per_page')
  final int perPage;
  @JsonKey(name: 'to')
  final int to;
  @JsonKey(name: 'total')
  final int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class Link {
  @JsonKey(name: 'url')
  final dynamic url;
  @JsonKey(name: 'label')
  final String label;
  @JsonKey(name: 'active')
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
