import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/category.dart';
import '../../domain/models/city.dart';
import '../../domain/models/sum_stat.dart';
import '../../domain/models/user.dart';
import '../../domain/models/user_category.dart';
import '../../domain/models/worker.dart';
import '../../utils/constants.dart';

class Client {
  final storage = const FlutterSecureStorage();

  String path = Constants.path;
  String token = '';

  var header = {'Content-Type': 'application/json'};

  Future<bool> register(String phoneNumber, String appSignature) async {
    Map<String, dynamic> body = {
      'username': '+$phoneNumber',
      'password': '1',
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
      'username': '+$phoneNumber',
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
      'username': '+$phoneNumber',
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
      print(json.decode(resBody));
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
      print(json.decode(resBody));
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

    Uri url = Uri.parse('$path/shop_client_views/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(json.decode(resBody));
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

    Uri url = Uri.parse('$path/statistics_today/');
    http.Request req = http.Request('GET', url);
    req.headers.addAll(headers);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(json.decode(resBody));
      List<SumStat> sumStat;
      var decode = (json.decode(resBody)['list'] as List);
      sumStat =
          decode.map((e) => SumStat.fromJson(e)).toList().reversed.toList();
      return sumStat;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }

  Future<void> createStore(
    int userId,
    int category,
    String name,
    double cashback,
    int province,
    int city,
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
      'user_id': userId
    };

    Uri url = Uri.parse('$path/shops_views/');
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

    Uri url = Uri.parse('$path/create_sotrutnik_view/');
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

  Future<void> getBalance() async {
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
      print(decode);
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

      print(userCategory.first.id.first);
      print(userCategory.first.name.first);
      return userCategory;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }
}
