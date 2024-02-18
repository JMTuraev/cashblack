import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api/business_api.dart';
import '../../core/api/seller_api.dart';
import '../../domain/models/common/category.dart';
import '../../domain/models/owner/business_profile.dart';
import '../../domain/models/owner/report_cashback.dart';
import '../../domain/models/seller/seller_owner_profile.dart';
// import '../../domain/models/category.dart';

class SellerViewModel extends ChangeNotifier {
  final SellerApi _sellerApi = SellerApi();

  int currentIndex = 0;

  bool isLoading = false;
  bool isEditing = false;
  bool isLoadingStats = false;
  bool isPaying = false;

  SellerOwnerProfile? sellerProfile;
  ReportCashback? sellerCashbackAndWithdraws;

  List<InlineCashbackAndWithdraw> mergedList = [];

  List<dynamic> stats = [];

  void setindex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void onChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    const storage = FlutterSecureStorage();

    // await prefs.remove('isLogged');
    // await storage.delete(key: 'token');
    await prefs.clear();
    await storage.deleteAll();
    currentIndex = 0;
    // notifyListeners();
  }

  Future<void> getSellerProfile() async {
    isLoading = true;
    sellerProfile = await _sellerApi.getSellerProfile();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getSellerCashbackStatistics() async {
    isLoadingStats = true;
    sellerCashbackAndWithdraws = await _sellerApi.getSellerCashbackStatistics();
    // mergedList = cashbackAndWithdraws.first.cashback;
    // cashbackAndWithdraws.forEach((element) {
    //   mergedList.addAll(element.cashback);
    // });

    mergedList
      ..addAll(sellerCashbackAndWithdraws!.withdraw)
      ..addAll(sellerCashbackAndWithdraws!.cashback);

    mergedList.sort(
        (a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)));

    isLoadingStats = false;
    notifyListeners();
  }

  Future<bool> payCashback(
    String clientPhone,
    String price,
  ) async {
    isPaying = true;
    final result = await _sellerApi.payCashback(clientPhone, price);
    isPaying = false;
    notifyListeners();
    return result;
  }

  Future<bool> editSellerProfile(
    String firstName,
    String lastName,
    String phone,
  ) async {
    isEditing = true;
    final res = await _sellerApi.editSellerProfile(firstName, lastName, phone);
    isEditing = false;
    notifyListeners();
    return res;
  }
}
