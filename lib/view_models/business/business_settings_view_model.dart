import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/owner/business_profile.dart';
import '../../domain/models/owner/seller_profile.dart';

class BusinessSettingsViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  bool isLoading = false;
  bool isDisabling = false;
  bool isGettingWorkers = false;
  BusinessProfile? businessProfile;
  List<SellerProfile> workers = [];

  Future<void> getOwnerProfile() async {
    isLoading = true;
    businessProfile = await _businessApi.getOwnerProfile();
    isLoading = false;
    notifyListeners();
  }

  Future<bool> createSeller(
    String phone,
    String nickname,
    String firstName,
    String lastName,
    String districtId,
    String shopId,
  ) async {
    isLoading = true;
    final res = await _businessApi.createSeller(
      phone,
      nickname,
      firstName,
      lastName,
      districtId,
      shopId,
    );
    isLoading = false;
    notifyListeners();
    return res;
  }

  Future<void> getWorkers() async {
    isGettingWorkers = true;
    workers = await _businessApi.getWorkers();
    isGettingWorkers = false;
    notifyListeners();
  }

  Future<bool> updateSellerStatus(int sellerId, int status) async {
    isDisabling = true;
    final res = await _businessApi.updateWorkerStatus(sellerId, status);
    isDisabling = false;
    notifyListeners();
    return res;
  }
}
