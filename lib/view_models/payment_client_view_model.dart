import 'package:flutter/cupertino.dart';

import '../core/api/client.dart';
import '../views/business/scanner_view/payment_success_view.dart';

class PaymentClientViewModel extends ChangeNotifier {
  // final Client _client = Client();

  // String price = '';

  // bool isLoading = false;
  // bool isSmallLoading = false;

  // Future<void> sendCashback(
  //     BuildContext context, String price, String barcodeId, int shopId) async {
  //   isLoading = true;
  //   notifyListeners();
  //   await _client.payCashback(price, barcodeId, shopId).then(
  //     (value) {
  //       isLoading = false;
  //       notifyListeners();
  //       return Navigator.of(context).pushAndRemoveUntil(
  //         CupertinoPageRoute(
  //           builder: (context) => const PaymentSuccessView(
  //             title: 'Кэшбек выплачено',
  //           ),
  //         ),
  //         (route) => false,
  //       );
  //     },
  //   );
  // }

  // Future<void> payForGoods(
  //     BuildContext context, String price, String barcodeId, int shopId) async {
  //   isSmallLoading = true;
  //   notifyListeners();
  //   await _client.payForGoods(price, barcodeId, shopId).then(
  //     (value) {
  //       isSmallLoading = false;
  //       notifyListeners();
  //       return Navigator.of(context).pushAndRemoveUntil(
  //         CupertinoPageRoute(
  //           builder: (context) => const PaymentSuccessView(
  //             title: 'Оплачено',
  //           ),
  //         ),
  //         (route) => false,
  //       );
  //     },
  //   );
  // }

  // // Future<void> sendCashbackWithPhone(
  // //     String price, String phone, int shopId) async {
  // //   await _client.payCashbackWithPhoneNumber(price, phone, shopId);
  // // }

  // Future<dynamic> getUserFromBarcode(String barcodeId, int shopId) async {
  //   return _client.getUserFromBarcode(barcodeId, shopId);
  // }

  // Future<void> payPhone(
  //     BuildContext context, String price, String phone, int shopId) async {
  //   isLoading = true;
  //   notifyListeners();
  //   await _client.payCashbackWithPhoneNumber(price, phone, shopId).then(
  //     (value) {
  //       isLoading = false;
  //       notifyListeners();
  //       return Navigator.of(context).pushAndRemoveUntil(
  //         CupertinoPageRoute(
  //           builder: (context) => const PaymentSuccessView(
  //             title: 'Оплачено',
  //           ),
  //         ),
  //         (route) => false,
  //       );
  //     },
  //   );
  // }
}
