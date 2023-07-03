import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/owner/notification_price.dart';
import '../../domain/models/owner/owner_notification.dart';

class BusinessNotificationsViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  bool isLoading = false;
  bool isLoadingNotifications = false;
  List<NotificationPrice> prices = [];
  List<OwnerNotification> notifations = [];

  Future<void> getPrices() async {
    isLoading = true;
    prices = await _businessApi.getPrices();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getNotifications() async {
    isLoadingNotifications = true;
    notifations = await _businessApi.getNotifications();
    isLoadingNotifications = false;
    notifyListeners();
  }
}
