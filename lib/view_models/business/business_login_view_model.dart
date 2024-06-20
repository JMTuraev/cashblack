import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/api/auth_api.dart';

class BusinessLoginViewModel extends ChangeNotifier {
  final AuthApi _authApi = AuthApi();

  String appSignature = '';
  String phone = '';
  // late User user;

  bool isLoading = false;

  Future<String> onEnterButtonPressed(
    String phone,
    String nickname,
    String firstName,
    String lastName,
    String districtId,
    String type,
    String? promoCode,
  ) async {
    isLoading = true;
    notifyListeners();
    final result = await _authApi.enterAuthDetails(
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

  Future<String> onVerifyButtonPressed(
    String phone,
    String code,
    String type,
  ) async {
    isLoading = true;
    notifyListeners();
    final result = await _authApi.login(phone, code, type);
    isLoading = false;
    notifyListeners();
    return result;
  }
}
