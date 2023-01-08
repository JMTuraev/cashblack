import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/balance.dart';
import '../../domain/models/category.dart';
import '../../domain/models/city.dart';
import '../../domain/models/one_month_statistic.dart';
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

  var header = {'Content-Type': 'application/json'};

  Future<bool> register(
    String phoneNumber,
    String appSignature,
    String promoCode,
  ) async {
    Map<String, dynamic> body = {
      'username': phoneNumber,
      'password': '1',
      //todo promocode
      'promo_code': promoCode,
      // 'groups': [1],
    };

    Uri url = Uri.parse('$path/user_sigin_up_views/$appSignature/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(header);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      if (resBody.contains('Bunday foydalanuvchi mavjud')) {
        return false;
      }
      token = 'Bearer ' + json.decode(resBody)['msg']['accsess'];
      await storage.write(key: 'bearer', value: token);
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
    req.headers.addAll(header);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      token = 'Bearer ' + json.decode(resBody)['token']['accsess'];
      await storage.write(key: 'bearer', value: token);
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<bool> registerClient(String phoneNumber, String appSignature) async {
    Map<String, dynamic> body = {
      'username': phoneNumber,
      'password': '1',
    };

    Uri url = Uri.parse('$path/create_client_view/$appSignature/');
    http.Request req = http.Request('POST', url);
    req.body = json.encode(body);
    req.headers.addAll(header);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      if (resBody.contains('Bunday foydalanuvchi mavjud')) {
        return false;
      }
      token = 'Bearer ' + json.decode(resBody)['msg']['accsess'];
      await storage.write(key: 'bearer', value: token);
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

    Uri url = Uri.parse('$path/user_sigin_up_views/$appSignature/');
    http.Request req = http.Request('PUT', url);
    // req.body = json.encode(body);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(json.decode(resBody));
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
      print(json.decode(resBody));
      if (json.decode(resBody)[0] == "Tizimga xush kelibsiz") {
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
      print(json.decode(resBody));
      List<Category> category;
      var decode = (json.decode(resBody) as List);
      category = decode.map((e) => Category.fromJson(e)).toList();
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
      print('user' + json.decode(resBody).toString());
      User user;
      var decode = (json.decode(resBody));
      user = User.fromJson(decode);
      return user;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  Future<void> changeName(int userId, String firstName, String lastName) async {
    print(token);
    Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
    };
    String? value = await storage.read(key: 'bearer');
    print(value);
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
      print(json.decode(resBody));
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
      print(json.decode(resBody));
      List<Province> province;
      var decode = (json.decode(resBody) as List);
      province = decode.map((e) => Province.fromJson(e)).toList();
      return province;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<City>> getCities() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/all_distrik_view/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print('statbiroy' + json.decode(resBody).toString());
      List<City> city;
      var decode = (json.decode(resBody) as List);
      city = decode.map((e) => City.fromJson(e)).toList();
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
      print('workers' + json.decode(resBody).toString());
      List<Worker> worker;
      var decode = (json.decode(resBody) as List);
      worker = decode.map((e) => Worker.fromJson(e)).toList().reversed.toList();
      return worker;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<List<SumStat>> getSumStatistics() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

//todo start end
    Uri url =
        Uri.parse('$path/cashbacks_filter_statistics/2022-01-01/2023-12-12/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print('stats' + json.decode(resBody).toString());
      List<SumStat> sumStat;
      var decode = (json.decode(resBody)['list'] as List);
      sumStat = decode.map((e) => SumStat.fromJson(e)).toList();
      return sumStat;
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
      print('biroylik' + json.decode(resBody).toString());
      List<OneMonthStatistic> sumStat;
      var decode = (json.decode(resBody)['list'] as List);
      sumStat = decode
          .map((e) => OneMonthStatistic.fromJson(e))
          .toList()
          .reversed
          .toList();
      print(sumStat);

      return sumStat;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<void> createStore(
    // int userId,
    int category,
    String name,
    double cashback,
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
      // 'user_id': userId,
      'brand_img': file,
    };

    Uri url = Uri.parse('$path/shops_views/');
    http.MultipartRequest req = http.MultipartRequest('POST', url);
    // req.body = json.encode(body);
    // req.headers.addAll(headers);
    req.fields['name_shops'] = name;
    req.fields['cashback'] = cashback.toString();
    req.fields['categor_id'] = category.toString();
    req.fields['provinse_id'] = province.toString();
    req.fields['distrik_id'] = city.toString();
    // req.fields['user_id'] = userId.toString();
    req.fields['distrik_id'] = city.toString();

    var picture = await http.MultipartFile.fromPath('brand_img', file.path);

    req.files.add(picture);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(json.decode(resBody));
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<void> editStore(
    int shopId,
    int category,
    String name,
    double cashback,
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
    http.MultipartRequest req = http.MultipartRequest('POST', url);
    // req.body = json.encode(body);
    // req.headers.addAll(headers);
    req.fields['name_shops'] = name;
    req.fields['cashback'] = cashback.toString();
    req.fields['categor_id'] = category.toString();
    req.fields['provinse_id'] = province.toString();
    req.fields['distrik_id'] = city.toString();
    req.fields['distrik_id'] = city.toString();

    var picture = await http.MultipartFile.fromPath('brand_img', file.path);

    req.files.add(picture);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(json.decode(resBody));
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
      print(json.decode(resBody));
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<Balance> getBalance() async {
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    Uri url = Uri.parse('$path/my_blance/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(json.decode(resBody));
      var decode = (json.decode(resBody));
      var decoded = Balance.fromJson(decode);
      print(decoded);
      return decoded;
    } else {
      print(res.reasonPhrase);
      throw Exception();
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
      print(json.decode(resBody));
      List<UserCategory> userCategory;

      // var decode = (json.decode(resBody));
      // print(decode);

      var decode = (json.decode(resBody) as List);
      userCategory = decode.map((e) => UserCategory.fromJson(e)).toList();

      print(userCategory.first.name);
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
      print(json.decode(resBody));
      List<UserShop> userShop;

      // var decode = (json.decode(resBody));
      // print(decode);

      var decode = (json.decode(resBody) as List);
      userShop = decode.map((e) => UserShop.fromJson(e)).toList();

      print(userShop.first.name);
      return userShop;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  Future<void> payCashback(
    String price,
    String barcodeId,
  ) async {
    Map<String, String> body = {
      'price': price,
    };
    String? value = await storage.read(key: 'bearer');
    Map<String, String> headers = {
      'Content-Type': ' application/json; charset=utf-8',
      'Authorization': value!
    };

    barcodeId = '2724815414507';

//todo batcode get
    Uri url = Uri.parse('$path/cashbak_create/$barcodeId/False/');
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
