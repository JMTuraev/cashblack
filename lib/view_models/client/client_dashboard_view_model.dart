import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../core/api/client_api.dart';
import '../../domain/models/client/client_category.dart';
import '../../domain/models/client/client_paying.dart';
import '../../domain/models/client/client_profile.dart';
import '../../domain/models/owner/business_profile.dart';
import '../../domain/models/owner/client_notification.dart';
import '../../domain/models/owner/report_cashback.dart';
import '../../domain/models/seller/seller_owner_profile.dart';

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
    clientCategories = await _clientApi.getPaidCategories();
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
