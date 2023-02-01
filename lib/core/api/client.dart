import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/balance.dart';
import '../../domain/models/barcode_scan.dart';
import '../../domain/models/category.dart';
import '../../domain/models/city.dart';
import '../../domain/models/client_statistics.dart';
import '../../domain/models/client_statistics_all.dart';
import '../../domain/models/one_month_statistic.dart';
import '../../domain/models/payment.dart';
import '../../domain/models/received_notification.dart';
import '../../domain/models/sent_notification.dart';
import '../../domain/models/sum_cashback.dart';
import '../../domain/models/sum_stat.dart';
import '../../domain/models/user.dart';
import '../../domain/models/user_category.dart';
import '../../domain/models/user_shop.dart';
import '../../domain/models/worker.dart';
import '../../utils/constants.dart';

class Client {
  final storage = const FlutterSecureStorage();

  String path = Constants.path;
  String token = '';

  final Map<String, String> _header = {'Content-Type': 'application/json'};

  Future<bool> register(
    String phoneNumber,
    String appSignature,
    String promoCode,
  ) async {
    Map<String, dynamic> body = {
      'username': phoneNumber,
      'password': '1',
      'promo_code': promoCode,
      // 'groups': [1],
    };

    if (appSignature.contains('/') || appSignature.isEmpty) {
      appSignature = '9er8fjshds';
    }

    Uri url = Uri.parse('$path/user_sigin_up_views/$appSignature/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(_header);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.contains('Bunday foydalanuvchi mavjud')) {
        return false;
      }
      token = 'Bearer ' + json.decode(resBody)['msg']['accsess'];
      await storage.write(key: 'bearer', value: token);
      await storage.write(key: 'phone', value: phoneNumber);
      return true;
    } else {
      print(res.reasonPhrase);
      return false;
    }
  }

  Future<void> login(String phoneNumber) async {
    Map<String, String> body = {
      'username': phoneNumber,
      'password': '1',
    };

    Uri url = Uri.parse('$path/user_sigin_in_views/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(_header);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      token = 'Bearer ' + json.decode(resBody)['token']['accsess'];
      await storage.write(key: 'bearer', value: token);
      await storage.write(key: 'phone', value: phoneNumber);
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<bool> registerClient(String phoneNumber, String appSignature) async {
    Map<String, dynamic> body = {
      'username': phoneNumber,
      'password': '1',
    };

    if (appSignature.contains('/')) {
      appSignature = '9er8fjshds';
    }

    Uri url = Uri.parse('$path/create_client_view/$appSignature/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(_header);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.contains('Bunday foydalanuvchi mavjud')) {
        return false;
      }
      token = 'Bearer ' + json.decode(resBody)['msg']['accsess'];
      await storage.write(key: 'bearer', value: token);
      await storage.write(key: 'phone', value: phoneNumber);
      return true;
    } else {
      print(res.reasonPhrase);
      return false;
    }
  }

  Future<void> sendSMS(String appSignature) async {
    // Map<String, String> body = {
    //   'message': 'send_sms',
    // };

    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    if (appSignature.contains('/') || appSignature.isEmpty) {
      appSignature = '9er8fjshds';
    }

    Uri url = Uri.parse('$path/user_sigin_up_views/$appSignature/');
    http.Request req = http.Request('PUT', url);
    // req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<bool> checkSMS(String code, String type) async {
// Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'code_s': code,
    };
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/check_sms/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      //TODO demo account and fix any sms code to enter the app
      if (json.decode(resBody)[0] == 'Tizimga xush kelibsiz' || 1 == 1) {
        await prefs.setBool('isLogged', true);
        await prefs.setBool(type, true);
        return true;
      }
      return false;
    } else {
      print(res.reasonPhrase);
      return false;
    }
  }

  Future<List<Category>> getCategories() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/all_categor_views/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<Category> category;
      var decode = (json.decode(resBody) as List);
      category = decode.map((e) => Category.fromJson(e)).toList();
      print('!!!!!getCategories');
      return category;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<User> getProfile() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/user_profiles_views/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      User user;
      var decode = (json.decode(resBody));
      user = User.fromJson(decode);
      print('!!!!!getProfile');
      return user;
    } else {
      print(res.reasonPhrase);
      if (res.reasonPhrase!.contains('Unauthorized')) {
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        print('ununun');
      }
      if (res.statusCode == 401) {
        //TODO token is expired
        print('refresh token');
        String? phone = await storage.read(key: 'phone');
        await login(phone!);
        await getProfile();
      }

      throw Exception();
    }
  }

  Future<void> changeName(int userId, String firstName, String lastName) async {
    Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
    };
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/user_update_fullname/$userId/');
    http.Request req = http.Request('PUT', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print('!!!!!changeName');
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<List<Province>> getProvincies() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/all_province_view/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<Province> province;
      var decode = (json.decode(resBody) as List);
      province = decode.map((e) => Province.fromJson(e)).toList();
      print('!!!!!provincies');

      return province;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<City>> getCities(String id) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/all_distrik_view/$id/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<City> city;
      var decode = (json.decode(resBody) as List);
      city = decode.map((e) => City.fromJson(e)).toList();
      print('!!!!!cities');
      return city;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<Worker>> getWorkers() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    // Uri url = Uri.parse('$path/shop_client_views/');
    Uri url = Uri.parse('$path/sotrutnik_view/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<Worker> worker;
      var decode = (json.decode(resBody) as List);
      worker = decode.map((e) => Worker.fromJson(e)).toList().reversed.toList();
      print('!!!!!!workers');
      return worker;
    } else {
      // print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<SumStat>> getSumStatistics({
    required String start,
    required String end,
  }) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/cashbacks_filter_statistics/$start/$end/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<SumStat> sumStat;
      var decode = (json.decode(resBody)['list'] as List);
      sumStat = decode.map((e) => SumStat.fromJson(e)).toList();
      print('!!!!!filter stats');
      return sumStat;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<SumCashback>> getCashbackStatistics() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/statistika_summa_view/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<SumCashback> sumCashback;
      var decode = (json.decode(resBody) as List);
      sumCashback = decode.map((e) => SumCashback.fromJson(e)).toList();
      print('!!!!!cashback stats');
      return sumCashback;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<OneMonthStatistic>> getOneMonthStatistics() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/cashback_one_month_statistics/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<OneMonthStatistic> sumStat;
      var decode = (json.decode(resBody)['list'] as List);
      sumStat = decode.map((e) => OneMonthStatistic.fromJson(e)).toList();
      print('!!!!!!!!oneweek');
      return sumStat;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<void> createStore(
    int category,
    String name,
    int cashback,
    int province,
    int city,
    File file,
  ) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };
    // Map<String, dynamic> body = {
    //   'name_shops': name,
    //   'cashback': cashback,
    //   'categor_id': category,
    //   'provinse_id': province,
    //   'distrik_id': city,
    //   'brand_img': file,
    // };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$path/shops_views/'),
    );
    request.fields.addAll({
      'name_shops': name,
      'cashback': cashback.toString(),
      'categor_id': category.toString(),
      'provinse_id': province.toString(),
      'distrik_id': city.toString(),
    });

    var picture = await http.MultipartFile.fromPath('brand_img', file.path);

    request.files.add(picture);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // await prefs.setBool('isBusiness', true);
    } else {
      print(response.reasonPhrase);
    }

    // Uri url = Uri.parse('$path/shops_views/');
    // http.MultipartRequest req = http.MultipartRequest('POST', url);
    // req.fields['name_shops'] = name;
    // req.fields['cashback'] = cashback.toString();
    // req.fields['categor_id'] = category.toString();
    // req.fields['provinse_id'] = province.toString();
    // req.fields['distrik_id'] = city.toString();

    // var picture = await http.MultipartFile.fromPath('brand_img', file.path);

    // req.files.add(picture);

    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();

    // if (res.statusCode >= 200 && res.statusCode < 300) {
    //
    // } else {
    //   print(res.reasonPhrase);
    // }
  }

  Future<void> sendNotification(
    String title,
    String content,
    File img,
  ) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    final prefs = await SharedPreferences.getInstance();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$path/all_notification_views/'),
    );
    request.fields.addAll({
      'title': title,
      'content': content,
    });

    var picture = await http.MultipartFile.fromPath('img', img.path);

    request.files.add(picture);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<List<SentNotification>> getSentNotifications() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    // Uri url = Uri.parse('$path/shop_client_views/');
    Uri url = Uri.parse('$path/all_notification_views/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<SentNotification> worker;
      var decode = (json.decode(resBody) as List);
      worker = decode
          .map((e) => SentNotification.fromJson(e))
          // .toList()
          // .reversed
          .toList();
      print('!!!!!sent notifs');
      return worker;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<ReceivedNotification>> getReceivedNotifications() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    // Uri url = Uri.parse('$path/shop_client_views/');
    Uri url = Uri.parse('$path/allClient_notification_view/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<ReceivedNotification> worker;
      var decode = (json.decode(resBody) as List);
      worker = decode
          .map((e) => ReceivedNotification.fromJson(e))
          .toList()
          .reversed
          .toList();
      print('!!!!!received notifs');

      return worker;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<void> editStore(
    int shopId,
    int category,
    String name,
    int cashback,
    int province,
    int city,
    File file,
  ) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };
    Map<String, dynamic> body = {
      'name_shops': name,
      'cashback': cashback,
      'categor_id': category,
      'provinse_id': province,
      'distrik_id': city,
      'brand_img': file,
    };

    Uri url = Uri.parse('$path/shops_update_view/$shopId/');
    http.MultipartRequest req = http.MultipartRequest('PUT', url);
    // req.body = json.encode(body);
    // req.headers.addAll(headers);
    req.fields['name_shops'] = name;
    req.fields['cashback'] = cashback.toString();
    req.fields['categor_id'] = category.toString();
    req.fields['provinse_id'] = province.toString();
    req.fields['distrik_id'] = city.toString();

    var picture = await http.MultipartFile.fromPath('brand_img', file.path);

    req.files.add(picture);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<void> createWorker(
    String userName,
    String password,
    String firstName,
    String lastName,
  ) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };
    Map<String, dynamic> body = {
      'username': userName,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
    };

    Uri url = Uri.parse('$path/sotrutnik_view/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print('!!!!!create worker');
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<void> switchWorker(int id, bool type) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };
    Map<String, dynamic> body = {
      'is_switcher': type == true ? 'True' : 'False',
    };

    Uri url = Uri.parse('$path/sotrutnik_switcher/${id.toString()}/');
    http.Request req = http.Request('PUT', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print('!!!!!swithc worker');
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<String> paySubscription(bool type) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };
    Map<String, dynamic> body = {
      'is_date': type,
    };

    Uri url = Uri.parse('$path/is_balans_view/');
    http.Request req = http.Request('PUT', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print('!!!!!subscribtion $type');
      if (resBody.contains('Yechildi')) {
        return 'OK';
      } else {
        return 'Xato';
      }
    } else {
      print(res.reasonPhrase);
      return 'Xato';
    }
  }

  Future<String> cancelSubscription() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/false_balans/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print('!!!!!unscribe');
      if (resBody.contains('access')) {
        return 'OK';
      } else {
        return 'Xato';
      }
    } else {
      print(res.reasonPhrase);
      return 'Xato';
    }
  }

  Future<List<Balance>> getBalance() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    // Uri url = Uri.parse('$path/shop_client_views/');
    Uri url = Uri.parse('$path/my_blance/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<Balance> worker;
      var decode = (json.decode(resBody) as List);
      worker =
          decode.map((e) => Balance.fromJson(e)).toList().reversed.toList();
      print('!!!!!balance');

      return worker;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<String> getNotificationPrice() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/notification_summ/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<Balance> worker;
      var decode = (json.decode(resBody)['msg'] as List);
      print('!!!!!notif price');

      return decode[0]['name'] ?? '0';
    } else {
      print(res.reasonPhrase);
      return '0';
    }
  }

  Future<dynamic> getUserFromBarcode(String barcode, int shopId) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    // Uri url = Uri.parse('$path/shop_client_views/');
    Uri url = Uri.parse('$path/cashbak_create/$barcode/False/$shopId/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // var decode = (json.decode(resBody) as List);
      BarcodeScan barcodeScan;
      var decode = (json.decode(resBody));
      barcodeScan = BarcodeScan.fromJson(decode);
      print('!!!!!get from barcode');
      return barcodeScan;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<Payment>> getPaymentHistory() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    // Uri url = Uri.parse('$path/shop_client_views/');
    Uri url = Uri.parse('$path/history_payment/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<Payment> worker;
      var decode = (json.decode(resBody) as List);
      worker =
          decode.map((e) => Payment.fromJson(e)).toList().reversed.toList();
      print('!!!!!histroy');

      return worker;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<UserCategory>> getRegisteredCategoriesForClient() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/client_category/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<UserCategory> userCategory;

      // var decode = (json.decode(resBody));
      // print(decode);

      var decode = (json.decode(resBody) as List);
      userCategory = decode.map((e) => UserCategory.fromJson(e)).toList();
      print('!!!!!registered categories for client');
      return userCategory;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  Future<List<UserShop>> getRegisteredMarketsForClient(int id) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/client_shops/$id/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<UserShop> userShop;

      // var decode = (json.decode(resBody));
      // print(decode);

      var decode = (json.decode(resBody) as List);
      userShop = decode.map((e) => UserShop.fromJson(e)).toList();
      print('!!!!!registered shops for client');

      return userShop;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  Future<ClientStatistics> getShopStatistics(int id) async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    // Uri url = Uri.parse('$path/shop_client_views/');
    Uri url = Uri.parse('$path/client_shops_statistics/$id');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      ClientStatistics user;
      var decode = (json.decode(resBody));
      user = ClientStatistics.fromJson(decode);
      print('!!!!get ShopStatistics');
      return user;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  Future<ClientStatisticsAll> getAllShopStatistics() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    // Uri url = Uri.parse('$path/shop_client_views/');
    Uri url = Uri.parse('$path/client_shops_sums/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      ClientStatisticsAll user;
      var decode = (json.decode(resBody));
      user = ClientStatisticsAll.fromJson(decode);
      print('!!!!get All ShopStatistics');

      return user;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  Future<void> payCashback(
    String price,
    String barcodeId,
    int shopId,
  ) async {
    Map<String, String> body = {
      'price': price,
    };
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/cashbak_create/$barcodeId/False/$shopId/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<void> payForGoods(
    String price,
    String barcodeId,
    int shopId,
  ) async {
    Map<String, String> body = {
      'price': price,
    };
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/cashbak_create/$barcodeId/True/$shopId/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<void> payCashbackWithPhoneNumber(
    String price,
    String phoneNumber,
    int shopId,
  ) async {
    Map<String, String> body = {
      'price': price,
    };
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse(
        '$path/client_phone_cahsback_view/$phoneNumber/False/$shopId/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<List<dynamic>> enterCardDetails(
    String cardNumber,
    String expireDate,
    String amount,
  ) async {
    Map<String, String> body = {
      'card_number': cardNumber,
      'expire_date': expireDate,
      'amount': amount
    };
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/payment_send_card/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.contains('Eng kam miqdor')) {
        return ['error_miqdor'];
      } else if (resBody.contains('Неправильные входные данные') ||
          resBody.contains('Карта не найдена') ||
          resBody.contains('errorCode')) {
        return ['Неправильные входные данные'];
      }
      List<dynamic> result = [
        cardNumber,
        expireDate,
        amount,
        json.decode(resBody)['msg']['result']['session'],
        json.decode(resBody)['msg']['result']['otpSentPhone']
      ];
      return result;
    } else {
      print(res.reasonPhrase);
      return ['xato'];
    }
  }

  Future<void> paymentConfirm(
    String cardNumber,
    String expireDate,
    String amount,
    int session,
    String otp,
  ) async {
    Map<String, dynamic> body = {
      'card_number': cardNumber,
      'expire_date': expireDate,
      'amount': amount,
      'session': session,
      'otp': otp,
    };

    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/payment_confirm_card/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(json.decode(resBody));
    } else {
      print(res.reasonPhrase);
    }
  }
}
