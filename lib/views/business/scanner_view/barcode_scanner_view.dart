import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../view_models/payment_client_view_model.dart';
import 'payment_client_view.dart';

class BarcodeScannerView extends StatelessWidget {
  const BarcodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сканер')),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
          } else {
            final String code = barcode.rawValue!;
            debugPrint('Barcode found! $code');
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => PaymentClientView(
                  code: code,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
