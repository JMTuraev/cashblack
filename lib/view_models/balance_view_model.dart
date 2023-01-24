import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/payment.dart';

class BalanceViewModel extends ChangeNotifier {
  final Client _client = Client();

  Future<List<dynamic>> enterCardDetails(
    String cardNumber,
    String expireDate,
    String amount,
  ) async {
    return _client.enterCardDetails(cardNumber, expireDate, amount);
  }

  Future<List<Payment>> getPayments() async {
    return _client.getPaymentHistory();
  }

  Future<void> paymentConfirm(
    String cardNumber,
    String expireDate,
    String amount,
    int session,
    String otp,
  ) async {
    await _client.paymentConfirm(cardNumber, expireDate, amount, session, otp);
  }
}
