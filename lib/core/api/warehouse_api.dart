import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/services/warehouse.dart';
import '../../domain/models/services/warehouse_category.dart';
import '../../domain/models/services/warehouse_item.dart';
import '../../domain/models/services/warehouse_prixod.dart';
import '../../domain/models/services/warehouse_prixod_create.dart';
import '../../domain/models/services/warehouse_provider.dart';
import '../../domain/models/services/warehouse_unit.dart';
import '../../string_extensions.dart';
import '../../utils/constants.dart';

class WarehousesApi {
  final Dio _dio = Dio();

  final _flutterSecureStorage = const FlutterSecureStorage();

  String? token = '';

  Future<void> _setDioHeader() async {
    token = await _flutterSecureStorage.read(key: 'token');

    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = token;
  }

  Future<List<Warehouse>> getWarehouses() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/warehouses');
    // var bookingList = response.data as List;

    final warehouses = (response.data['data'] as List)
        .map((x) => Warehouse.fromJson(x as Map<String, Object?>))
        .toList();

    print('get warehouses');

    return warehouses;
  }

  Future<bool> createWarehouse({
    required String name,
    required String address,
    required String shopId,
  }) async {
    await _setDioHeader();

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/warehouses',
        data: FormData.fromMap(
          {
            // 'parent_id': '', // nullable
            'name': name,
            'address': address,
            'shop_id': shopId,
          },
        ),
      );
      final result = response.data;

      print('$result');
      // return 'checkout.paycom.uz/$result';
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

  Future<List<WarehouseUnit>> getWarehouseUnits() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/unit');
    // var bookingList = response.data as List;

    final warehouseUnits = (response.data['data'] as List)
        .map((x) => WarehouseUnit.fromJson(x as Map<String, Object?>))
        .toList();

    print('get warehouse units');

    return warehouseUnits;
  }

  Future<List<WarehouseProvider>> getWarehouseProviders() async {
    await _setDioHeader();

    final response =
        await _dio.get('${Constants.path}/v1/owner/warehouse/provider');
    // var bookingList = response.data as List;

    final warehouseProviders = (response.data['data'] as List)
        .map((x) => WarehouseProvider.fromJson(x as Map<String, Object?>))
        .toList();

    print('get warehouse providers');

    return warehouseProviders;
  }

  Future<bool> createWarehouseProvider({
    required String name,
    required String email,
    required String phone,
  }) async {
    await _setDioHeader();

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/warehouse/provider',
        data: FormData.fromMap(
          {
            // 'parent_id': '', // nullable
            'name': name,
            'email': email,
            'phone': phone,
          },
        ),
      );
      final result = response.data;

      print('$result');
      // return 'checkout.paycom.uz/$result';
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

  Future<List<WarehouseCategory>> getWarehouseCategories() async {
    await _setDioHeader();

    final response =
        await _dio.get('${Constants.path}/v1/owner/warehouse/category');
    // var bookingList = response.data as List;

    final warehouseCategories = (response.data['data'] as List)
        .map((x) => WarehouseCategory.fromJson(x as Map<String, Object?>))
        .toList();

    print('get warehouse cats');

    return warehouseCategories;
  }

  Future<bool> createWarehouseCategory({
    required String name,
    required String title,
    //String parentId,
  }) async {
    await _setDioHeader();

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/warehouse/category',
        data: FormData.fromMap(
          {
            // 'parent_id': '', // nullable
            'name': name,
            'title': title,
          },
        ),
      );
      final result = response.data;

      print('$result');
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

  Future<List<WarehouseItem>> getWarehouseItems() async {
    await _setDioHeader();

    final response =
        await _dio.get('${Constants.path}/v1/owner/warehouse/product');
    // var bookingList = response.data as List;

    final warehouseItems = (response.data['data'] as List)
        .map((x) => WarehouseItem.fromJson(x as Map<String, Object?>))
        .toList();

    print('get warehouse items');

    return warehouseItems;
  }

  Future<bool> createWarehouseItem({
    required String categoryId,
    required String barCode,
    required String name,
    required String lower,
    String remark = '',
  }) async {
    await _setDioHeader();

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/warehouse/product',
        data: FormData.fromMap(
          {
            'category_id': categoryId,
            'bar_code': barCode,
            'name': name,
            'remark': remark,
            'lower': lower.removeWhitespace(),
          },
        ),
      );
      final result = response.data;

      print('$result');
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

//prixod
  Future<WarehousePrixod> getWarehousePrixodItems() async {
    await _setDioHeader();

    final response =
        await _dio.get('${Constants.path}/v1/owner/warehouse/invoice');
    // var bookingList = response.data as List;

    final warehousePrixodItems =
        WarehousePrixod.fromJson(response.data as Map<String, Object?>);

    print('get warehouse prixod items');

    return warehousePrixodItems;
  }

  Future<bool> createWarehousePrixod({
    required String number,
    required String date,
    required String warehouseId,
    required String providerId,
    required List<WarehousePrixodCreate> products,
  }) async {
    await _setDioHeader();

    final productsToSend = <String, String>{
      'number': number.removeWhitespace(),
      'date_at': date,
      'warehouse_id': warehouseId,
      'provider_id': providerId,
    };

    for (var i = 0; i < products.length; i++) {
      productsToSend.addAll({
        'product[$i][id]': products[i].productiId,
        'product[$i][qty]': products[i].quantity,
        'product[$i][unit_id]': products[i].unitId,
        'product[$i][price]': products[i].price,
        'product[$i][sell_price]': products[i].priceSell,
      });
    }

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/warehouse/product',
        data: FormData.fromMap(productsToSend),
      );
      final result = response.data;

      print('$result');
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }
}
