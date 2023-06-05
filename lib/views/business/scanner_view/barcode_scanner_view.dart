import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../view_models/business/business_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import 'payment_client_view.dart';
import 'payment_phone_view.dart';

class BarcodeScannerView extends StatelessWidget {
  BarcodeScannerView({super.key, required this.shopId});

  final int shopId;

  MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    int scannedTime = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оплата через QR'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.width - 40,
              width: MediaQuery.of(context).size.width - 40,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: controller,
                    // allowDuplicates: false,
                    onDetect: (barcode) {
                      final List<Barcode> codes = barcode.barcodes;

                      // debugPrint('Barcode found! $code');
                      for (final barcode in codes) {
                        if (barcode.rawValue != null) {
                          scannedTime += 1;
                        }

                        if (scannedTime == 1) {
                          // context.read<BusinessViewModel>().currentIndex = 0;
                          context.read<BusinessViewModel>().setindex(0);
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => PaymentClientView(
                                code: barcode.rawValue!,
                                shopId: shopId,
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  Positioned(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Center(
                      child: Image.asset(
                        'assets/images/frame.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'или',
                    style: TextStyle(fontSize: 16),
                  ),
                  // const Divider(
                  //   thickness: 2,
                  //   color: Colors.grey,
                  //   height: 30,
                  // ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.white, Colors.black],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft)),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 2),
                        //   child: Row(
                        //     children: [
                        //       Icon(
                        //         Icons.star,
                        //         size: 15,
                        //       ),
                        //       Icon(
                        //         Icons.star,
                        //         size: 30,
                        //       ),
                        //       Icon(
                        //         Icons.star,
                        //         size: 15,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width / 2,
                          height: 1,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.white, Colors.black],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MainButtonWidget(
                    method: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => PaymentPhoneView(
                            shopId: shopId,
                          ),
                        ),
                      );
                    },
                    text: 'Оплата по номеру',
                    // color: Colors.black45,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
