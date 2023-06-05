import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../core/api/client_api.dart';
import '../../domain/models/client/client_category.dart';
import '../../domain/models/client/client_profile.dart';
import '../../domain/models/owner/business_profile.dart';
import '../../domain/models/owner/seller_profile.dart';

class ClientDashboardViewModel extends ChangeNotifier {
  final ClientApi _clientApi = ClientApi();

  bool isLoading = false;
  bool isDisabling = false;
  bool isGettingWorkers = false;
  ClientProfile? clientProfile;
  List<ClientCategory> clientCategories = [];

  Future<void> getClientCategories() async {
    isLoading = true;
    clientCategories = await _clientApi.getPaidCategories();
    isLoading = false;
    notifyListeners();
  }
}
