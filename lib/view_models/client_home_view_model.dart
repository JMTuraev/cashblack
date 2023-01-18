import 'package:flutter/material.dart';

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

  Future<void> getProfile() async {
    user = await _client.getProfile();
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
}
