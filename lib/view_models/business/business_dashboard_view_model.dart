import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/owner/business_company.dart';
import '../../domain/models/owner/business_shop.dart';
import '../../domain/models/owner/weekly_stat.dart';

class BusinessDashboardViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  bool isLoading = false;
  bool isGettingCompany = false;
  bool isGettingShops = false;
  bool isWeeklyLoading = false;
  BusinessCompany? businessCompany;
  List<BusinessShop>? businessShops = [];
  List<WeeklyStat> weeklyStatistics = [];
  double maxSum = 10;

  bool hasCompany = false;
  bool hasShops = false;

  Future<void> clearData() async {
    businessCompany = null;
    businessShops = [];
    weeklyStatistics = [];
    maxSum = 10;
    hasCompany = false;
    hasShops = false;
    isLoading = false;
    isWeeklyLoading = false;
    isGettingCompany = false;
    isGettingShops = false;
  }

  Future<void> getBusinessCompany() async {
    try {
      isGettingCompany = true;
      businessCompany = await _businessApi.getBusinessCompany();

      hasCompany = true;
    } on Exception catch (e) {
      businessCompany = null;
      hasCompany = false;
    }

    isGettingCompany = false;

    // if (businessCompany == null) {
    //   hasCompany = false;
    // } else {
    //   hasCompany = true;
    // }
    notifyListeners();
  }

  Future<void> getWeeklyStatistics(int shopId) async {
    maxSum = 10;
    isWeeklyLoading = true;
    weeklyStatistics = await _businessApi.getWeeklyStatistics(shopId);
    for (final e in weeklyStatistics) {
      maxSum += double.parse(e.totalCashback.toString());
    }
    isWeeklyLoading = false;
    notifyListeners();
  }

  Future<void> getBusinessShops() async {
    try {
      isGettingShops = true;
      businessShops = await _businessApi.getBusinessShops();
      hasShops = true;
    } on Exception catch (e) {
      businessShops = [];
      hasShops = false;
    }
    // if (businessShops == null) {
    //   businessShops = [];
    //   hasShops = false;
    // } else {
    //   hasShops = true;
    // }
    isGettingShops = false;

    print('------------------');
    print(isGettingShops);
    notifyListeners();
  }

  Future<String> payment(
    String amount,
  ) async {
    isLoading = true;
    // notifyListeners();
    final result = await _businessApi.getPaymentUrl(amount);
    // paymentUrl = result;
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> createBusinessCompany(
    String name,
    String address,
    String passwordSerial,
    String passwordNumber,
    String inn,
    String pinfl,
    // String provinceId,
    String districtId,
  ) async {
    isLoading = true;
    final res = await _businessApi.createBusinessCompany(
      name,
      address,
      passwordSerial,
      passwordNumber,
      inn,
      pinfl,
      districtId,
    );
    isLoading = false;
    notifyListeners();
    return res;
  }

  Future<bool> createLocalStore(
    String name,
    String percent,
    String waymark,
    int category,
    String districtId,
    String address,
  ) async {
    isLoading = true;
    final res = await _businessApi.createStore(
      name,
      percent,
      waymark,
      category,
      districtId,
      address,
    );
    isLoading = false;
    notifyListeners();
    return res;
  }

  Future<bool> editLocalStore(
    int shopId,
    String name,
    String percent,
    String waymark,
    int category,
    String districtId,
    String address,
  ) async {
    isLoading = true;
    final res = await _businessApi.editBusinessShop(
      shopId,
      name,
      percent,
      waymark,
      category,
      districtId,
      address,
    );
    isLoading = false;
    notifyListeners();
    return res;
  }
}
