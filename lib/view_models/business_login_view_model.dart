import 'package:flutter/material.dart';

import '../core/api/client.dart';

class BusinessLoginViewModel extends ChangeNotifier {
  final Client _client = Client();

  String appSignature = '';
  String phone = '';
  // late User user;

  bool isLoading = false;

  Future<void> sendSms(
      String phoneNumber, String phoneId, String promoCode) async {
    isLoading = true;
    notifyListeners();
    phone = phoneNumber;
    bool isRegister =
        await _client.register(phoneNumber, appSignature, promoCode);
    if (!isRegister) {
      await _client.login(phoneNumber);
    }
    await _client.sendSMS(phoneId);
    isLoading = false;
    notifyListeners();
  }

  Future<bool> onVerifyButtonPressed(String code) async {
    return await _client.checkSMS(code, 'isBusiness');
  }

  // Future<void> getProfile() async {
  //   user = await _client.getProfile();
  // }
}
