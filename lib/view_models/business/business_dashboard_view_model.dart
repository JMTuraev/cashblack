import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/owner/business_company.dart';
import '../../domain/models/owner/business_shop.dart';
import '../../domain/models/owner/weekly_stat.dart';

class BusinessDashboardViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  bool isLoading = false;
  bool isCreatingStore = false;
  bool isCreatingCompany = false;
  bool isEditingStore = false;
  bool isGettingCompany = false;
  bool isGettingShops = false;
  bool isWeeklyLoading = false;
  BusinessCompany? businessCompany;
  List<BusinessShop>? businessShops = [];
  List<BusinessShop>? businessShopsAll = [];
  List<WeeklyStat> weeklyStatistics = [];
  // double maxSum = 0;
  double maxCashback = 0;
  // double totalCashback = 0;
  // double totalWithdraw = 0;

  bool hasCompany = false;
  bool hasShops = false;

  Future<void> clearData() async {
    businessCompany = null;
    businessShops = [];
    businessShopsAll = [];
    weeklyStatistics = [];
    // maxSum = 0;
    maxCashback = 0;
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
    // maxSum = 0;
    maxCashback = 0;
    // totalCashback = 0;
    // totalWithdraw = 0;
    isWeeklyLoading = true;
    weeklyStatistics = await _businessApi.getWeeklyStatistics(shopId);
    for (final element in weeklyStatistics) {
      final item = double.parse(element.totalCashback.toString());
      if (item > maxCashback) {
        maxCashback = item;
      }
    }
    // for (final e in weeklyStatistics) {
    //   maxSum += double.parse(e.totalCashback.toString());
    //   totalCashback += double.parse(e.cashback.toString());
    //   totalWithdraw += double.parse(e.withdraw.toString());
    // }
    isWeeklyLoading = false;
    notifyListeners();
  }

  Future<void> getBusinessShops() async {
    try {
      isGettingShops = true;
      businessShops = await _businessApi.getBusinessShops();
      businessShopsAll = [...businessShops ?? []];
      businessShops =
          businessShops?.where((element) => element.status == true).toList();
      hasShops = true;
    } on Exception catch (e) {
      businessShops = [];
      businessShopsAll = [];
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
    isCreatingCompany = true;
    notifyListeners();
    final res = await _businessApi.createBusinessCompany(
      name,
      address,
      passwordSerial,
      passwordNumber,
      inn,
      pinfl,
      districtId,
    );
    isCreatingCompany = false;
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
    isCreatingStore = true;
    notifyListeners();
    final res = await _businessApi.createStore(
      name,
      percent,
      waymark,
      category,
      districtId,
      address,
    );
    isCreatingStore = false;
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
    isEditingStore = true;
    notifyListeners();
    final res = await _businessApi.editBusinessShop(
      shopId,
      name,
      percent,
      waymark,
      category,
      districtId,
      address,
    );
    isEditingStore = false;
    notifyListeners();
    return res;
  }

  Future<bool> hideOrShowShop(
    int shopId,
    int status,
  ) async {
    isLoading = true;
    final res = await _businessApi.hideOrShowShop(
      shopId,
      status,
    );
    isLoading = false;
    notifyListeners();
    return res;
  }
}
