import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/api/auth_api.dart';

class BusinessLoginViewModel extends ChangeNotifier {
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
    var result = await _authApi.login(phone, code, 'owner');
    isLoading = false;
    notifyListeners();
    return result;
  }
}
