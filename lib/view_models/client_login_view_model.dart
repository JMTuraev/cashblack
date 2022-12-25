import 'package:flutter/material.dart';

import '../core/api/client.dart';

class ClientLoginViewModel extends ChangeNotifier {
  final Client _client = Client();

  String appSignature = '';
  String phone = '';
  // late User user;

  bool isLoading = false;

  Future<void> sendSms(String phoneNumber, String phoneId) async {
    isLoading = true;
    notifyListeners();
    phone = phoneNumber;
    bool isRegister = await _client.registerClient(
      phoneNumber,
      appSignature,
    );
    if (!isRegister) {
      await _client.login(phoneNumber);
    }
    await _client.sendSMS(phoneId);
    isLoading = false;
    notifyListeners();
  }

  Future<bool> onVerifyButtonPressed(String code) async {
    return _client.checkSMS(code, 'isClient');
  }

  // Future<void> getProfile() async {
  //   user = await _client.getProfile();
  // }
}
