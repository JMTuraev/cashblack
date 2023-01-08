import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/payment_client_view_model.dart';
import '../../../widgets/helpers.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';
import 'payment_success_view.dart';

class PaymentClientView extends StatelessWidget {
  const PaymentClientView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();

    return ScreenWrapper(
        child: Column(
      children: [
        Form(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Klient Ism Familiya',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text('1234567890123'),
                const SizedBox(height: 100),
                // MediumTitleWidget(text: 'Начисление'),
                // const SizedBox(height: 20),
                // Text(
                //   'Klient Ism Familiya',
                //   style: TextStyle(fontSize: 18),
                // ),
                // const SizedBox(height: 4),
                // Text('1234567890123'),
                // const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Сумма',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  controller: priceController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardAppearance: Brightness.dark,
                  showCursor: true,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                MainButtonWidget(
                  text: 'Начисление',
                  method: () async {
                    // await context
                    //     .read<PaymentClientViewModel>()
                    //     .sendCashback(priceController.text, 'barcodeId')
                    //     .then(
                    //       (value) => Navigator.pushReplacement(
                    //         context,
                    //         CupertinoPageRoute(
                    //           builder: (context) => PaymentSuccessView(),
                    //         ),
                    //       ),
                    //     );
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 100),
        Form(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                // MediumTitleWidget(text: 'Начисление'),
                // const SizedBox(height: 20),
                // Text(
                //   'Klient Ism Familiya',
                //   style: TextStyle(fontSize: 18),
                // ),
                // const SizedBox(height: 4),
                // Text('1234567890123'),
                // const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Сумма',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  controller: priceController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardAppearance: Brightness.dark,
                  showCursor: true,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                MainButtonWidget(
                  text: 'Pay',
                  method: () async {
                    await context
                        .read<PaymentClientViewModel>()
                        .sendCashback(priceController.text, 'barcodeId')
                        .then(
                          (value) => Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => PaymentSuccessView(),
                            ),
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
