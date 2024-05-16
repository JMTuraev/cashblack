import 'package:flutter/cupertino.dart';

import '../../core/api/client_api.dart';
import '../../domain/models/client/client_profile.dart';
import '../../domain/models/owner/seller_profile.dart';

class ClientSettingsViewModel extends ChangeNotifier {
  final ClientApi _clientApi = ClientApi();

  bool isLoading = false;
  bool isEditing = false;
  bool isDisabling = false;
  bool isGettingWorkers = false;
  ClientProfile? clientProfile;
  List<SellerProfile> workers = [];

  Future<void> getClientProfile() async {
    isLoading = true;
    clientProfile = await _clientApi.getClientProfile();
    isLoading = false;
    notifyListeners();
  }

  Future<bool> deleteClientProfile() async {
    isLoading = true;
    final res = await _clientApi.deleteClientProfile();
    isLoading = false;
    notifyListeners();
    return res;
  }

  Future<bool> editClientProfile(
    String firstName,
    String lastName,
    String phone,
  ) async {
    isEditing = true;
    final res = await _clientApi.editClientProfile(firstName, lastName, phone);
    isEditing = false;
    notifyListeners();
    return res;
  }
}
