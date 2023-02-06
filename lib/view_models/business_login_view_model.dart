import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../widgets/info_alert_widget.dart';

class BusinessLoginViewModel extends ChangeNotifier {
  final Client _client = Client();

  String appSignature = '';
  String phone = '';
  // late User user;

  bool isLoading = false;

  Future<bool> sendSms(
      String phoneNumber, String phoneId, String promoCode) async {
    isLoading = true;
    notifyListeners();
    phone = phoneNumber;
    bool isRegister =
        await _client.register(phoneNumber, appSignature, promoCode);
    if (!isRegister) {
      await _client.login(phoneNumber);
    }

    var user = await _client.getProfile();
    if (user.groups.first.name == 'Client') {
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
    return await _client.checkSMS(code, 'isBusiness', phone);
  }

  // Future<void> getProfile() async {
  //   user = await _client.getProfile();
  // }
}
