import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/services/warehouse.dart';
import '../../domain/models/services/warehouse_category.dart';
import '../../domain/models/services/warehouse_provider.dart';
import '../../domain/models/services/warehouse_unit.dart';
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
}
