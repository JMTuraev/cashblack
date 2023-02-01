import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/client.dart';
import '../domain/models/balance.dart';
import '../domain/models/one_month_statistic.dart';
import '../domain/models/user.dart';
import '../domain/models/worker.dart';

class BusinessHomeViewModel extends ChangeNotifier {
  final Client _client = Client();

  int currentIndex = 0;

  void setindex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  late User user;
  // User?   user;
  // List<Balance> balance = [];
  late List<Balance> balance;
  List<Worker> workers = [];
  // List<OneMonthStatistic> oneWeekStatistics = [];

  Future<List<Object>> getFuture() async {
    user = await getProfile();
    balance = await getBalance();

    return [user, balance];
  }

  Future<User> getProfile() async {
    user = await _client.getProfile();
    notifyListeners();
    return user;
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

  Future<void> createWorker(String userName, String password, String firstName,
      String lastName) async {
    await _client.createWorker(userName, password, firstName, lastName);
    await getWorkers();
    notifyListeners();
  }

  Future<List<Worker>> getWorkers() async {
    return workers = await _client.getWorkers();
  }

  Future<void> switchWorker(int id, bool type) async {
    await _client.switchWorker(id, type);
    print('wor changed to $type');
    await getWorkers();
    notifyListeners();
  }

  Future<List<Balance>> getBalance() async {
    var balance = await _client.getBalance();
    notifyListeners();
    return balance;
  }

  Future<String> paySubscription(bool type) async {
    var result = await _client.paySubscription(type);
    user = await getProfile();
    balance = await getBalance();
    notifyListeners();
    return result;
  }

  Future<String> cancelSubscription() async {
    var result = await _client.cancelSubscription();
    user = await getProfile();
    balance = await getBalance();
    notifyListeners();
    return result;
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

  Future<void> editstore(int id, int category, String name, int cashback,
      int province, int city, File file) async {
    await _client.editStore(id, category, name, cashback, province, city, file);
    await getProfile();
    notifyListeners();
  }
}
