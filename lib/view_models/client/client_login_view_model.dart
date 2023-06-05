import 'package:flutter/material.dart';

import '../../core/api/auth_api.dart';
import '../../core/api/client.dart';

class ClientLoginViewModel extends ChangeNotifier {
  final AuthApi _authApi = AuthApi();

  String appSignature = '';
  String phone = '';
  // late User user;

  bool isLoading = false;

  Future<bool> onEnterButtonPressed(
    String phone,
    String nickname,
    String firstName,
    String lastName,
    String districtId,
    String type,
    String? promoCode,
  ) async {
    isLoading = true;
    var result = await _authApi.enterAuthDetails(
      phone,
      nickname,
      firstName,
      lastName,
      districtId,
      type,
      promoCode,
    );
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> onVerifyButtonPressed(
    String phone,
    String code,
  ) async {
    isLoading = true;
    var result = await _authApi.login(phone, code, 'client');
    isLoading = false;
    notifyListeners();
    return result;
  }
}
