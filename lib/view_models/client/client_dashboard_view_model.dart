import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../core/api/client_api.dart';
import '../../domain/models/client/client_category.dart';
import '../../domain/models/client/client_paying.dart';
import '../../domain/models/client/client_profile.dart';
import '../../domain/models/owner/client_notification.dart';

class ClientDashboardViewModel extends ChangeNotifier {
  final ClientApi _clientApi = ClientApi();

  bool isLoading = false;
  bool isLoadingCashbakcs = false;
  bool isLoadingNotifications = false;
  bool isLiking = false;
  bool isOpening = false;
  ClientProfile? clientProfile;
  List<ClientCategory> clientCategories = [];
  List<ClientPaying> payings = [];
  ClientNotification notifications =
      ClientNotification(count: 0, notifications: []);

  Future<void> getClientCategories() async {
    isLoading = true;
    // await _clientApi.getPaidCategoriesNew();
    // await _clientApi.getPaidShopsNew();

    clientCategories = await _clientApi.getPaidCategoriesOld();
    final filteredData = clientCategories.map((category) {
      final filteredShops = category.shops.where((shop) {
        return shop.cashback.isNotEmpty || shop.withdraw.isNotEmpty;
      }).toList();

      if (filteredShops.isNotEmpty) {
        final cc = ClientCategory(
          id: category.id,
          name: category.name,
          title: category.title,
          logo: category.logo,
          count: category.count,
          shops: category.shops,
        );
        cc
          ..shops =
              cc.shops.where((element) => element.cashback.isNotEmpty).toList()
          ..count = cc.shops.length;
        return cc;
      }
      return ClientCategory(
        id: -1,
        name: '',
        title: '',
        logo: '',
        count: -1,
        shops: [],
      );
    }).toList();

    clientCategories =
        filteredData.where((element) => element.id != -1).toList();

    inspect(clientCategories);

    isLoading = false;
    notifyListeners();
  }

  Future<void> getCashbacks(int shopId) async {
    isLoadingCashbakcs = true;
    payings = await _clientApi.getCashbacks(shopId);
    isLoadingCashbakcs = false;
    notifyListeners();
  }

  Future<void> getNotifications() async {
    isLoadingNotifications = true;
    notifications = await _clientApi.getNotifications();
    isLoadingNotifications = false;
    notifyListeners();
  }

  Future<void> likeNotification(int id, int status) async {
    isLiking = true;
    notifyListeners();
    await _clientApi.likeNotifications(id, status);
    isLiking = false;
    notifyListeners();
  }

  Future<void> readNotification(int id) async {
    isOpening = true;
    await _clientApi.readNotifications(id);
    isOpening = false;
    notifyListeners();
  }
}
