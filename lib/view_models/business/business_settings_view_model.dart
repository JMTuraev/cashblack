import 'package:image_picker/image_picker.dart';

import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/owner/business_profile.dart';
import '../../domain/models/owner/seller_profile.dart';

class BusinessSettingsViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  bool isLoading = false;
  bool isDeleting = false;
  bool isCreatingWorker = false;
  // bool isLoadingProfile = false;
  bool isDisabling = false;
  bool isGettingWorkers = false;
  BusinessProfile? businessProfile = BusinessProfile(
    id: -1,
    phone: '0',
    nickname: '',
    firstName: '',
    lastName: '',
    balance: '0',
    totalAmount: '0',
    totalExpense: '0',
    type: 'owner',
    status: 1,
    licence: [],
  );
  List<SellerProfile> workers = [];
  bool isEditing = false;
  bool isUploading = false;

  Future<bool> getOwnerProfile() async {
    isLoading = true;
    // notifyListeners();
    businessProfile = await _businessApi.getOwnerProfile();
    isLoading = false;
    notifyListeners();
    if (businessProfile!.id == -1) {
      return false;
    }
    return true;
  }

  Future<bool> deleteBusinessProfile() async {
    isDeleting = true;
    notifyListeners();
    final res = await _businessApi.deleteBusinessProfile();
    isDeleting = false;
    notifyListeners();
    return res;
  }

  Future<bool> subscribe(int priceId) async {
    isLoading = true;
    notifyListeners();
    final res = await _businessApi.subscribe(priceId);
    isLoading = false;
    notifyListeners();
    return res;
  }

  Future<bool> editOwnerProfile(
    String firstName,
    String lastName,
    String phone,
  ) async {
    isEditing = true;
    notifyListeners();
    final res = await _businessApi.editOwnerProfile(firstName, lastName, phone);
    isEditing = false;
    notifyListeners();
    return res;
  }

  Future<bool> editBusinessCompany(
    String name,
    String address,
    String passwordSerial,
    String passwordNumber,
    String inn,
    String pinfl,
    // String provinceId,
    String districtId,
  ) async {
    isEditing = true;
    notifyListeners();
    final res = await _businessApi.editBusinessCompany(
      name,
      address,
      passwordSerial,
      passwordNumber,
      inn,
      pinfl,
      districtId,
    );
    isEditing = false;
    notifyListeners();
    return res;
  }

  Future<bool> createSeller(
    String phone,
    String nickname,
    String firstName,
    String lastName,
    String districtId,
    String shopId,
  ) async {
    isCreatingWorker = true;
    notifyListeners();
    final res = await _businessApi.createSeller(
      phone,
      nickname,
      firstName,
      lastName,
      districtId,
      shopId,
    );
    isCreatingWorker = false;
    notifyListeners();
    return res;
  }

  Future<void> getWorkers() async {
    isGettingWorkers = true;
    // notifyListeners();
    workers = await _businessApi.getWorkers();
    isGettingWorkers = false;
    notifyListeners();
  }

  Future<bool> updateSellerStatus(int sellerId, int status) async {
    isDisabling = true;
    notifyListeners();
    final res = await _businessApi.updateWorkerStatus(sellerId, status);
    isDisabling = false;
    notifyListeners();
    return res;
  }

  Future<bool> uploadCompanyAvatar(XFile file) async {
    isUploading = true;
    notifyListeners();
    final res = await _businessApi.uploadCompanyAvatar(file);
    isUploading = false;
    notifyListeners();
    return res;
  }

  Future<bool> uploadShopAvatar(XFile file, int shopId) async {
    isUploading = true;
    notifyListeners();
    final res = await _businessApi.uploadShopAvatar(file, shopId);
    isUploading = false;
    notifyListeners();
    return res;
  }
}
