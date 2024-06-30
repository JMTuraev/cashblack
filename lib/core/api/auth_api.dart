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

  Future<String> enterAuthDetails(
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
            'promo_code': promoCode,
            // date == null ? '' : 'date_at': date,
          },
        ),
      );
      if (response.data['message'] == 'sms code error') {
        return 'sms_error';
      }
      if (response.data['message'] == 'User error') {
        return 'type_error';
      }
      if (response.data['type'] != type) {
        return 'type_error';
      }
      print(
        'register ${response.data['type']} as $type ${response.data['code']}',
      );
      return 'true';
    } on DioError catch (e) {
      print(e.response!.data);
      if (e.response?.data['message'] == 'sms code error') {
        return 'sms_error';
      }
      if (e.response?.data['message'] == 'User error') {
        return 'type_error';
      }
      if (e.response?.data['type'] != type) {
        return 'type_error';
      }
      return 'false';
    }
  }

  Future<String> login(String phone, String code, String userType) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['content-Type'] = 'multipart/form-data';
    // _dio.options.headers['Authorization'] = token;

    var smsCode = code;

    if (phone == '000000050') {
      smsCode = '400000';
    }
    if (phone == '000000051') {
      smsCode = '400000';
    }

    try {
      final response = await _dio.post(
        '${Constants.path}/auth/login',
        data: FormData.fromMap(
          {
            'phone': '998$phone',
            'sms_code': smsCode,
            'type': userType,
          },
        ),
      );
      if (response.data['error'] == true) {
        return '';
      }
      // print('login $code ${response.data['token']}');
      print('logined as ${response.data['type']}');
      await _flutterSecureStorage.write(
        key: 'token',
        value: 'Bearer ${response.data['token']}',
      );
      final type = response.data['type'].toString();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogged', true);
      await prefs.setBool('isBusiness', userType != 'client' ? true : false);
      await prefs.setBool(
        'isSeller',
        type == 'seller' ? true : false,
      );
      return type;
    } on DioError catch (e) {
      print(e.response!.data);
      return '';
    }
  }
}
