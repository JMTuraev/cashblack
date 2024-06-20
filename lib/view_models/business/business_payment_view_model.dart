import 'package:flutter/material.dart';

import '../../core/api/business_api.dart';
import '../../core/api/seller_api.dart';
import '../../domain/models/client/client_profile.dart';
import '../../domain/models/owner/bonus_price.dart';

class BusinessPaymentViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();
  final SellerApi _sellerApi = SellerApi();
  bool isLoading = false;
  bool isCheckProfileLoading = false;
  ClientProfile? clientProfile;
  bool isPriceLoading = false;
  List<BonusPrice> bonusPrices = [];

  Future<bool> setShopBeforeCashbackOrWithdraw(
    String shopId,
  ) async {
    isLoading = true;
    final result = await _businessApi.setShopBeforeCashbackOrWithdraw(shopId);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> payCashback(
    // String shopId,
    String clientPhone,
    String price,
  ) async {
    isLoading = true;
    final result = await _businessApi.payCashback(clientPhone, price);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> payWithdraw(
    // String shopId,
    String clientPhone,
    String price,
  ) async {
    isLoading = true;
    notifyListeners();

    final result = await _businessApi.payWithdraw(clientPhone, price);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> payWithdrawForSeller(
    // String shopId,
    String clientPhone,
    String price,
  ) async {
    isLoading = true;
    notifyListeners();

    final result = await _businessApi.payWithdrawForSeller(clientPhone, price);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<ClientProfile> getCashbackAmountBeforePay(
    String phone,
  ) async {
    isCheckProfileLoading = true;
    final result = await _businessApi.getCashbackAmountBeforePay(phone);
    clientProfile = result;
    isCheckProfileLoading = false;
    notifyListeners();
    return result;
  }

  Future<ClientProfile> getCashbackAmountBeforePayForSeller(
    String phone,
  ) async {
    isCheckProfileLoading = true;
    notifyListeners();
    final result = await _sellerApi.prepareForCashback(phone);
    clientProfile = result;
    isCheckProfileLoading = false;
    notifyListeners();
    return result;
  }

  Future<void> getBonusPrices() async {
    isPriceLoading = true;
    bonusPrices = await _businessApi.getBonusPrices();
    isPriceLoading = false;
    // notifyListeners();
  }
}
