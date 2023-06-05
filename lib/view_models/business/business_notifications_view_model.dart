import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/owner/notification_price.dart';

class BusinessNotificationsViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  bool isLoading = false;
  List<NotificationPrice> prices = [];

  Future<void> getPrices() async {
    isLoading = true;
    prices = await _businessApi.getPrices();
    isLoading = false;
    notifyListeners();
  }
}
