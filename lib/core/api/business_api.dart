import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/common/category.dart';
// import '../../domain/models/category.dart';
import '../../domain/models/owner/bonus_price.dart';
import '../../domain/models/owner/business_company.dart';
import '../../domain/models/owner/business_profile.dart';
import '../../domain/models/owner/business_shop.dart';
import '../../domain/models/owner/cashback.dart';
import '../../domain/models/owner/notification_price.dart';
import '../../domain/models/owner/seller_profile.dart';
import '../../string_extensions.dart';
import '../../utils/constants.dart';

import 'package:http/http.dart' as http;

class BusinessApi {
  final Dio _dio = Dio();

  final _flutterSecureStorage = const FlutterSecureStorage();

  String? token = '';

  Future<void> _setDioHeader() async {
    token = await _flutterSecureStorage.read(key: 'token');

    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = token;
  }

  Future<BusinessProfile> getOwnerProfile() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/profile');
    // var bookingList = response.data as List;
    final owner =
        BusinessProfile.fromJson(response.data['data'] as Map<String, Object?>);
    print('get ownerprofile');

    return owner;
  }

  Future<List<NotificationPrice>> getPrices() async {
    _dio.options.headers['content-Type'] = 'application/json';

    final response = await _dio.get('${Constants.path}/v1/prices');
    // var bookingList = response.data as List;
    final prices = (response.data['data'] as List)
        .map((x) => NotificationPrice.fromJson(x as Map<String, Object?>))
        .toList();
    print('get prices for notifs');

    return prices;
  }

  Future<List<BonusPrice>> getBonusPrices() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/bonus');
    // var bookingList = response.data as List;
    final prices = (response.data['data'] as List)
        .map((x) => BonusPrice.fromJson(x as Map<String, Object?>))
        .toList();
    print('get prices for bonuses');

    return prices;
  }

  Future<BusinessCompany> getBusinessCompany() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/company');
    // var bookingList = response.data as List;
    final businessCompany =
        BusinessCompany.fromJson(response.data['data'] as Map<String, Object?>);
    print('get business comapny');

    return businessCompany;
  }

  Future<List<SellerProfile>> getWorkers() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/users');
    // var bookingList = response.data as List;

    final workers = (response.data['data'] as List)
        .map((x) => SellerProfile.fromJson(x as Map<String, Object?>))
        .toList();

    print('get workers');

    return workers;
  }

  Future<bool> updateWorkerStatus(int sellerId, int status) async {
    String? token = await _flutterSecureStorage.read(key: 'token');

    final headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token.toString(),
    };
    final request = http.Request(
        'PUT', Uri.parse('${Constants.path}/v1/owner/users/$sellerId'));
    request.bodyFields = {
      'status': status.toString(),
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

  Future<bool> createBusinessCompany(
    String name,
    String address,
    String passwordSerial,
    String passwordNumber,
    String inn,
    String pinfl,
    // String provinceId,
    String districtId,
  ) async {
    String? token = await _flutterSecureStorage.read(key: 'token');

    _dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['Authorization'] = token;

    try {
      final response = await _dio.post(
        '${Constants.path}/owner/v1/owner',
        data: FormData.fromMap(
          {
            'name': name,
            'address': address,
            'p_seria': passwordSerial,
            'p_number': passwordNumber,
            'inn': inn,
            'pinfl': pinfl,
            // 'province_id': provinceId,
            'district_id': districtId,
          },
        ),
      );

      print('create company');

      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

  Future<bool> createSeller(
    String phone,
    String nickname,
    String firstName,
    String lastName,
    String districtId,
    String shopId,
  ) async {
    String? token = await _flutterSecureStorage.read(key: 'token');

    _dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['Authorization'] = token;

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/users',
        data: FormData.fromMap(
          {
            'phone': phone,
            'nickname': nickname,
            'first_name': firstName,
            'last_name': lastName,
            'district_id': districtId,
            'shop_id': shopId,
          },
        ),
      );

      print('create seller');

      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

  Future<bool> createStore(
    String name,
    String percent,
    String waymark,
    int category,
    String districtId,
    String address,
  ) async {
    String? token = await _flutterSecureStorage.read(key: 'token');

    // _dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['content-Type'] = 'multipart/form-data';
    _dio.options.headers['Authorization'] = token;

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/shop',
        data: FormData.fromMap(
          {
            'name': name,
            'percent': percent,
            'waymark': waymark,
            'category_shop_id': category,
            'district_id': districtId,
            'address': address,
          },
        ),
      );

      print('create local store');

      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

  Future<List<BusinessShop>> getBusinessShops() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/shop');
    // var bookingList = response.data as List;

    final businessShops = (response.data['data'] as List)
        .map((x) => BusinessShop.fromJson(x as Map<String, Object?>))
        .toList();

    print('get business shops');

    return businessShops;
  }

  Future<String> getPaymentUrl(String amount) async {
    await _setDioHeader();

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/order',
        data: FormData.fromMap(
          {
            'bonus_id': amount,
          },
        ),
      );
      final result = response.data['basic'];

      print('payme $result');
      return 'checkout.paycom.uz/$result';
    } on DioError catch (e) {
      print(e.response!.data);
      return '';
    }
  }

  Future<List<Cashback>> getCashbackAmountBeforePay() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/cashback');
    final cashbacks = (response.data['data'] as List)
        .map((x) => Cashback.fromJson(x as Map<String, Object?>))
        .toList();

    print('get categories');

    return cashbacks;
  }

  Future<bool> payCashback(
    String shopId,
    String clientPhone,
    String price,
  ) async {
    await _setDioHeader();

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/cashback',
        data: FormData.fromMap(
          {
            'shop_id': shopId,
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

  Future<List<Category>> getCategories() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/category');
    // var bookingList = response.data as List;

    final categories = (response.data['data'] as List)
        .map((x) => Category.fromJson(x as Map<String, Object?>))
        .toList();

    print('get categories');

    return categories;
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
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }
}
