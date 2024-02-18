import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/owner/business_profile.dart';
import '../../domain/models/owner/report_cashback.dart';
import '../../domain/models/seller/seller_owner_profile.dart';

import 'package:http/http.dart' as http;

import '../../string_extensions.dart';
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

  Future<SellerOwnerProfile> getSellerProfile() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/seller/profile');
    // var bookingList = response.data as List;
    final seller = SellerOwnerProfile.fromJson(
        response.data['data'] as Map<String, Object?>);
    print('get sellerprofile');

    return seller;
  }

  Future<bool> editSellerProfile(
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
        http.Request('PUT', Uri.parse('${Constants.path}/v1/seller/profile'));
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

  Future<ReportCashback> getSellerCashbackStatistics() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/report/cashback');

    final cashbacks =
        ReportCashback.fromJson(response.data['data'] as Map<String, Object?>);

    print('get seller cashbakc stats');

    return cashbacks;
  }

  Future<bool> payCashback(
    String clientPhone,
    String price,
  ) async {
    await _setDioHeader();

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/seller/cashback',
        data: FormData.fromMap(
          {
            'client_phone': clientPhone,
            'price': price.removeWhitespace(),
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
