import 'package:flutter/material.dart';

import '../core/api/client.dart';

class ClientLoginViewModel extends ChangeNotifier {
  final Client _client = Client();

  String appSignature = '';
  String phone = '';
  // late User user;

  bool isLoading = false;

  Future<bool> sendSms(String phoneNumber, String phoneId) async {
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
    var user = await _client.getProfile();
    if (user.groups.first.name != 'Client') {
      // await showCupertinoDialog(
      //   context: context,
      //   builder: (context) {
      //     return const InfoAlertWidget(title: 'Bu klient');
      //   },
      // );
      isLoading = false;
      notifyListeners();
      return false;
    }
    await _client.sendSMS(phoneId);
    isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> onVerifyButtonPressed(String code, String phone) async {
    isLoading = true;
    notifyListeners();
    var result = await _client.checkSMS(code, 'isClient', phone);
    isLoading = false;
    notifyListeners();
    return result;
  }

  // Future<void> getProfile() async {
  //   user = await _client.getProfile();
  // }
}
