import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/client.dart';
import '../domain/models/client_statistics.dart';
import '../domain/models/received_notification.dart';
import '../domain/models/user.dart';
import '../domain/models/user_category.dart';
import '../domain/models/user_shop.dart';

class ClientHomeViewModel extends ChangeNotifier {
  final Client _client = Client();

  int currentIndex = 0;

  late User user;
  late List<UserCategory> userCategory;
  late List<UserShop> userShop;

  Future<User> getProfile() async {
    return user = await _client.getProfile();
  }

  // Future<void> getCategories() async {
  //   userCategory = await _client.getRegisteredCategoriesForClient();
  // }

  Future<List<UserCategory>> getJoinedCategories() async {
    return _client.getRegisteredCategoriesForClient();
  }

  Future<List<UserShop>> getJoinedShops(int id) async {
    return _client.getRegisteredMarketsForClient(id);
  }

  Future<ClientStatistics> getShopStatistics(int id) async {
    return _client.getShopStatistics(id);
  }

  Future<List<ReceivedNotification>> getNotifications() async {
    return _client.getReceivedNotifications();
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
