import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/owner/business_company.dart';
import '../../domain/models/owner/business_shop.dart';

class BusinessDashboardViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  bool isLoading = false;
  BusinessCompany? businessCompany;
  List<BusinessShop> businessShops = [];

  Future<void> getBusinessCompany() async {
    isLoading = true;
    businessCompany = await _businessApi.getBusinessCompany();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getBusinessShops() async {
    isLoading = true;
    businessShops = await _businessApi.getBusinessShops();
    isLoading = false;
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
    var res = await _businessApi.createBusinessCompany(
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
    var res = await _businessApi.createStore(
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
