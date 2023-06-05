import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class AuthApi {
  final Dio _dio = Dio();

  final _flutterSecureStorage = const FlutterSecureStorage();

  String? token = '';

  Future<void> _setDioHeader() async {
    token = await _flutterSecureStorage.read(key: 'token');

    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = token;
  }

  Future<bool> enterAuthDetails(
    String phone,
    String nickname,
    String firstName,
    String lastName,
    String districtId,
    String type,
    String? promoCode,
  ) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['content-Type'] = 'multipart/form-data';
    // _dio.options.headers['Authorization'] = token;

    try {
      final response = await _dio.post(
        '${Constants.path}/auth/registration',
        data: FormData.fromMap(
          {
            'phone': phone,
            'nickname': nickname,
            'first_name': firstName,
            'last_name': lastName,
            'district_id': districtId,
            'type': type,
            'promo_code': promoCode
            // date == null ? '' : 'date_at': date,
          },
        ),
      );
      print('register $type ${response.data['code']}');
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

  Future<bool> login(String phone, String code, String userType) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['content-Type'] = 'multipart/form-data';
    // _dio.options.headers['Authorization'] = token;

    try {
      final response = await _dio.post(
        '${Constants.path}/auth/login',
        data: FormData.fromMap(
          {
            'phone': phone,
            'sms_code': code,
          },
        ),
      );
      print('login $code ${response.data['token']}');
      await _flutterSecureStorage.write(
        key: 'token',
        value: 'Bearer ${response.data['token']}',
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogged', true);
      await prefs.setBool('isBusiness', userType != 'client' ? true : false);
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }
}
