import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/client/client_profile.dart';
import '../../domain/models/common/category.dart';
// import '../../domain/models/category.dart';
import '../../domain/models/owner/bonus_price.dart';
import '../../domain/models/owner/business_company.dart';
import '../../domain/models/owner/business_profile.dart';
import '../../domain/models/owner/business_shop.dart';
import '../../domain/models/owner/cashback.dart';
import '../../domain/models/owner/notification_price.dart';
import '../../domain/models/owner/owner_notification.dart';
import '../../domain/models/owner/report_cashback.dart';
import '../../domain/models/owner/report_cashback_client.dart';
import '../../domain/models/owner/seller_profile.dart';
import '../../domain/models/owner/weekly_stat.dart';
import '../../string_extensions.dart';
import '../../utils/constants.dart';

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

  Future<List<OwnerNotification>> getNotifications() async {
    await _setDioHeader();

    // final response =
    // await _dio.get('${Constants.path}/v1/owner/announcement');
    final response = await _dio.get('${Constants.path}/v1/owner/announcement');

    // var bookingList = response.data as List;
    final notifs = (response.data['data'] as List)
        .map((x) => OwnerNotification.fromJson(x as Map<String, Object?>))
        .toList()
        .reversed
        .toList();
    print('owner notifs');

    return notifs;
  }

  Future<bool> sendNotification(
    int priceId,
    String title,
    String text,
    String avatarId,
    String shopId,
    File? image,
  ) async {
    await _setDioHeader();

    var formData = FormData.fromMap({
      'price_id': priceId,
      'title': title,
      'text': text,
      'avatar_id': avatarId,
      'shop_id': shopId,
    });
    if (image != null) {
      formData = FormData.fromMap({
        'price_id': priceId,
        'title': title,
        'text': text,
        'avatar_id': avatarId,
        'shop_id': shopId,
        'image': await MultipartFile.fromFile(image.path),
      });
    }
    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/announcement',
        data: formData,
      );
      print('send notif');

      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

  Future<bool> subscribe(int priceId) async {
    await _setDioHeader();

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/announcement',
        data: FormData.fromMap(
          {
            'price_id': priceId,
          },
        ),
      );

      print('subscribe one month');

      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
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

  Future<BusinessCompany?> getBusinessCompany() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/company');
    // var bookingList = response.data as List;
    try {
      final businessCompany = BusinessCompany.fromJson(
          response.data['data'] as Map<String, Object?>);
      print('get business comapny');

      return businessCompany;
    } on Exception catch (e) {
      print('no comp');
      return null;
    }
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
    var token = await _flutterSecureStorage.read(key: 'token');

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

    var response = await request.send();

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
    var token = await _flutterSecureStorage.read(key: 'token');

    _dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['Authorization'] = token;

    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/company',
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

  Future<bool> editBusinessCompany(
    String name,
    String address,
    String passwordSerial,
    String passwordNumber,
    String inn,
    String pinfl,
    // String provinceId,
    String districtId,
  ) async {
    var token = await _flutterSecureStorage.read(key: 'token');

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token!
    };
    final request =
        http.Request('PUT', Uri.parse('${Constants.path}/v1/owner/company'));
    request.bodyFields = {
      'name': name,
      'address': address,
      'p_seria': passwordSerial,
      'inn': inn,
      'p_number': passwordNumber,
      'pinfl': pinfl,
      'district_id': '59'
    };
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<bool> editBusinessShop(
    int shopId,
    String name,
    String percent,
    String waymark,
    int category,
    String districtId,
    String address,
  ) async {
    var token = await _flutterSecureStorage.read(key: 'token');

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token!
    };
    final request = http.Request(
        'PUT', Uri.parse('${Constants.path}/v1/owner/shop/$shopId'));
    request.bodyFields = {
      'name': name,
      'percent': percent,
      'waymark': waymark,
      'category_shop_id': category.toString(),
      'district_id': districtId,
      'address': address,
    };
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
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
    var token = await _flutterSecureStorage.read(key: 'token');

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
    var token = await _flutterSecureStorage.read(key: 'token');

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

  Future<List<BusinessShop>?> getBusinessShops() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/owner/shop');
    // var bookingList = response.data as List;

    try {
      final businessShops = (response.data['data'] as List)
          .map((x) => BusinessShop.fromJson(x as Map<String, Object?>))
          .toList();

      print('get business shops');

      return businessShops;
    } on Exception catch (e) {
      print('no shops');

      return null;
    }
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

  Future<ClientProfile> getCashbackAmountBeforePay(String phone) async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/client?phone=$phone');
    final cashbacks =
        ClientProfile.fromJson(response.data['data'] as Map<String, Object?>);

    print('get before pay');

    return cashbacks;
  }

  Future<List<ReportCashback>> getCashbackStatistics() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/report/cashback');
    final cashbacks = (response.data['data'] as List)
        .map((x) => ReportCashback.fromJson(x as Map<String, Object?>))
        .toList();

    print('get cashback stats');

    return cashbacks;
  }

  Future<List<ReportCashbackClient>> getCashbackStatisticsByClient() async {
    await _setDioHeader();

    final response = await _dio.get('${Constants.path}/v1/report/by-clients');
    final cashbacks = (response.data['data'] as List)
        .map((x) => ReportCashbackClient.fromJson(x as Map<String, Object?>))
        .toList();

    print('get cashback stats client');

    return cashbacks;
  }

  Future<List<WeeklyStat>> getWeeklyStatistics(int shopId) async {
    await _setDioHeader();

    final response = await _dio
        .get('${Constants.path}/v1/report/by-days?days=6&shop_id=$shopId');
    final cashbacks = (response.data['data'] as List)
        .map((x) => WeeklyStat.fromJson(x as Map<String, Object?>))
        .toList();

    print('get cashback stats weekly');

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

  Future<bool> editOwnerProfile(
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
        http.Request('PUT', Uri.parse('${Constants.path}/v1/owner/profile'));
    request.bodyFields = {
      'nickname': phone,
      'first_name': firstName,
      'last_name': lastName,
      'district_id': '59'
    };
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<bool> uploadShopAvatar(File file, int shopId) async {
    // String fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'logo': await MultipartFile.fromFile(file.path),
    });
    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/shop/logo/$shopId',
        data: formData,
      );
      print('upload avatar');

      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }

  Future<bool> uploadCompanyAvatar(File file) async {
    // String fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'logo': await MultipartFile.fromFile(file.path),
    });
    try {
      final response = await _dio.post(
        '${Constants.path}/v1/owner/company/logo',
        data: formData,
      );
      print('upload avatar');

      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }
}
