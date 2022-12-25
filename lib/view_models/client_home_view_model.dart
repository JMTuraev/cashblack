import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/user.dart';

class ClientHomeViewModel extends ChangeNotifier {
  final Client _client = Client();

  int currentIndex = 0;

  late User user;

  Future<void> getProfile() async {
    user = await _client.getProfile();
  }

  void onChange(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
