import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_details.dart';
import '../../../view_models/business_home_view_model.dart';
import 'payment_client_view.dart';

class BarcodeScannerView extends StatelessWidget {
  const BarcodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    int scannedTime = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Сканер'),
        bottom: ThemeDetails.appBarDivider,
      ),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
          } else {
            final String code = barcode.rawValue!;
            debugPrint('Barcode found! $code');
            scannedTime += 1;
            if (scannedTime == 1) {
              context.read<BusinessHomeViewModel>().currentIndex = 0;
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => PaymentClientView(
                    code: code,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
