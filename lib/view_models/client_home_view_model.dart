import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/client.dart';
// import '../domain/models/client_statistics.dart';
// import '../domain/models/client_statistics_all.dart';
// import '../domain/models/received_notification.dart';
// import '../domain/models/user.dart';
// import '../domain/models/user_category.dart';
// import '../domain/models/user_shop.dart';

class ClientHomeViewModel extends ChangeNotifier {
  // final Client _client = Client();

  // int currentIndex = 0;

  // late User user;
  // late List<UserCategory> userCategory;
  // late List<UserShop> userShop;

  // Future<User> getProfile() async {
  //   return user = await _client.getProfile();
  // }

  // // Future<void> getCategories() async {
  // //   userCategory = await _client.getRegisteredCategoriesForClient();
  // // }

  // Future<List<UserCategory>> getJoinedCategories() async {
  //   var registeredCategoriesForClient =
  //       _client.getRegisteredCategoriesForClient();
  //   // notifyListeners();

  //   return registeredCategoriesForClient;
  // }

  // Future<List<UserShop>> getJoinedShops(int id) async {
  //   var registeredMarketsForClient = _client.getRegisteredMarketsForClient(id);
  //   // notifyListeners();

  //   return registeredMarketsForClient;
  // }

  // Future<ClientStatistics> getShopStatistics(int id) async {
  //   var shopStatistics = _client.getShopStatistics(id);
  //   // notifyListeners();
  //   return shopStatistics;
  // }

  // Future<ClientStatisticsAll> getAllShopStatistics() async {
  //   var allShopStatistics = _client.getAllShopStatistics();
  //   // notifyListeners();
  //   return allShopStatistics;
  // }

  // Future<List<ReceivedNotification>> getNotifications() async {
  //   var receivedNotifications = _client.getReceivedNotifications();
  //   // notifyListeners();
  //   return receivedNotifications;
  // }

  // void onChange(int index) {
  //   currentIndex = index;
  //   notifyListeners();
  // }

  // Future<void> changeName(int userId, String firstName, String lastName) async {
  //   await _client.changeName(userId, firstName, lastName);
  //   await getProfile();
  //   notifyListeners();
  // }

  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final storage = FlutterSecureStorage();

  //   // await prefs.remove('isLogged');
  //   // await storage.delete(key: 'token');
  //   await prefs.clear();
  //   await storage.deleteAll();
  //   currentIndex = 0;
  //   // notifyListeners();
  // }
}
