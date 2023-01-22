import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/client.dart';
import '../domain/models/balance.dart';
import '../domain/models/one_month_statistic.dart';
import '../domain/models/user.dart';
import 'package:flutter/material.dart';

import '../domain/models/worker.dart';

class BusinessHomeViewModel extends ChangeNotifier {
  final Client _client = Client();

  int currentIndex = 0;

  late User user;
  // List<OneMonthStatistic> oneWeekStatistics = [];

  Future<User> getProfile() async {
    return user = await _client.getProfile();
  }

  Future<List<OneMonthStatistic>> getStatistics() async {
    return _client.getOneMonthStatistics();
  }

  void onChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> changeName(int userId, String firstName, String lastName) async {
    await _client.changeName(userId, firstName, lastName);
    await getProfile();
    notifyListeners();
  }

  Future<void> createWorker(
    String userName,
    String password,
    String firstName,
    String lastName,
  ) async {
    await _client.createWorker(userName, password, firstName, lastName);
    notifyListeners();
  }

  Future<List<Worker>> getWorkers() async {
    return _client.getWorkers();
  }

  Future<List<Balance>> getBalance() async {
    return _client.getBalance();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final storage = FlutterSecureStorage();

    // await prefs.remove('isLogged');
    // await storage.delete(key: 'bearer');
    await prefs.clear();
    await storage.deleteAll();
    currentIndex = 0;
    // notifyListeners();
  }
}
