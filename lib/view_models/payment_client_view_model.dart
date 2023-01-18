import 'package:flutter/material.dart';

import '../core/api/client.dart';

class PaymentClientViewModel extends ChangeNotifier {
  final Client _client = Client();

  String price = '';

  Future<void> sendCashback(String price, String barcodeId) async {
    await _client.payCashback(price, barcodeId);
  }

  Future<void> payForGoods(String price, String barcodeId) async {
    await _client.payForGoods(price, barcodeId);
  }

  Future<dynamic> getUserFromBarcode(String barcodeId) async {
    return _client.getUserFromBarcode(barcodeId);
  }
}
