import 'package:flutter/material.dart';

import '../core/api/client.dart';

class PaymentClientViewModel extends ChangeNotifier {
  final Client _client = Client();

  String price = '';

  Future<void> sendCashback(String price, String barcodeId, int shopId) async {
    await _client.payCashback(price, barcodeId, shopId);
  }

  Future<void> payForGoods(String price, String barcodeId, int shopId) async {
    await _client.payForGoods(price, barcodeId, shopId);
  }

  Future<void> sendCashbackWithPhone(
      String price, String phone, int shopId) async {
    await _client.payCashbackWithPhoneNumber(price, phone, shopId);
  }

  Future<dynamic> getUserFromBarcode(String barcodeId, int shopId) async {
    return _client.getUserFromBarcode(barcodeId, shopId);
  }
}
