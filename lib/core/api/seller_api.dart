import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../utils/constants.dart';

class SellerApi {
  final Dio _dio = Dio();

  final _flutterSecureStorage = const FlutterSecureStorage();

  String? token = '';

  Future<void> _setDioHeader() async {
    token = await _flutterSecureStorage.read(key: 'token');

    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = token;
  }

  Future<String> prepareForCashback(String phone) async {
    String? token = await _flutterSecureStorage.read(key: 'token');

    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = token;

    final response =
        await _dio.get('${Constants.path}/v1/seller/client?phone=$phone');
    // var bookingList = response.data as List;

    // final businessShops = (response.data['data'] as List)
    //     .map((x) => BusinessShop.fromJson(x as Map<String, Object?>))
    //     .toList();

    print('get prepare cashback');

    return 'businessShops';
  }
}
