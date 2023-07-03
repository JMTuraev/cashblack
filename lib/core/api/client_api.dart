import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/client/client_category.dart';
import '../../domain/models/client/client_paying.dart';
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

  Future<bool> editClientProfile(
    String firstName,
    String lastName,
    String phone,
  ) async {
    token = await _flutterSecureStorage.read(key: 'token');
    final headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token!,
    };
    final request =
        http.Request('PUT', Uri.parse('${Constants.path}/v1/client/profile'));
    request.bodyFields = {
      'nickname': phone,
      'first_name': firstName,
      'last_name': lastName,
      'district_id': '59'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
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

  Future<List<ClientPaying>> getCashbacks(int shopId) async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/report/by-category');
    final payings = (response.data['data'] as List)
        .map((x) => ClientPaying.fromJson(x as Map<String, Object?>))
        .toList();

    print('get client payings ${payings.length}');

    return payings;
  }
}
