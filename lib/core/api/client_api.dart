import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/client/client_category.dart';
import '../../domain/models/client/client_profile.dart';
import '../../utils/constants.dart';

class ClientApi {
  final Dio _dio = Dio();

  final _flutterSecureStorage = const FlutterSecureStorage();
  String? token = '';
  Future<void> _setDioHeader() async {
    token = await _flutterSecureStorage.read(key: 'token');

    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = token;
  }

  Future<ClientProfile> getClientProfile() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/client/profile');
    final owner =
        ClientProfile.fromJson(response.data['data'] as Map<String, Object?>);
    print('get clientprofile');

    return owner;
  }

  Future<List<ClientCategory>> getPaidCategories() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/report/by-category');
    final clientCategories = (response.data['data'] as List)
        .map((x) => ClientCategory.fromJson(x as Map<String, Object?>))
        .toList();

    print('get client categories ${clientCategories.length}');

    return clientCategories;
  }
}
