import 'package:flutter/material.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/client/client_profile.dart';
import '../../domain/models/owner/bonus_price.dart';

class BusinessPaymentViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();
  bool isLoading = false;
  bool isPriceLoading = false;
  List<BonusPrice> bonusPrices = [];

  Future<bool> payCashback(
    String shopId,
    String clientPhone,
    String price,
  ) async {
    isLoading = true;
    final result = await _businessApi.payCashback(shopId, clientPhone, price);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<ClientProfile> getCashbackAmountBeforePay(
    String phone,
  ) async {
    isLoading = true;
    final result = await _businessApi.getCashbackAmountBeforePay(phone);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<void> getBonusPrices() async {
    isPriceLoading = true;
    bonusPrices = await _businessApi.getBonusPrices();
    isPriceLoading = false;
    notifyListeners();
  }
}
