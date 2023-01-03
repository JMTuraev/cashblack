import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/user.dart';
import '../domain/models/user_category.dart';

class ClientHomeViewModel extends ChangeNotifier {
  final Client _client = Client();

  int currentIndex = 0;

  late User user;
  late List<UserCategory> userCategory;

  Future<void> getProfile() async {
    user = await _client.getProfile();
  }

  Future<void> getCategories() async {
    userCategory = await _client.getRegisteredCategoriesForClient();
  }

  void onChange(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
