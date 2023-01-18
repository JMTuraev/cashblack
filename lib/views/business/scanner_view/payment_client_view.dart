// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/payment_client_view_model.dart';
import '../../../widgets/helpers.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';
import 'payment_success_view.dart';

import 'package:cashblack/extensions.dart';

class PaymentClientView extends StatelessWidget {
  const PaymentClientView({
    Key? key,
    required this.code,
  }) : super(key: key);

  final String code;

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    TextEditingController cashBackController = TextEditingController();

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            FutureBuilder(
              future: context
                  .read<PaymentClientViewModel>()
                  .getUserFromBarcode(code),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var user = snapshot.data;
                  return Column(
                    children: [
                      Text(
                        user['full_name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['username'].toString().phoneFormatter(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Form(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Сумма покупки',
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
                      await context
                          .read<PaymentClientViewModel>()
                          .sendCashback(priceController.text, code)
                          .then(
                            (value) => Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const PaymentSuccessView(),
                              ),
                              (route) => false,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            Form(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Сумма товаров',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    controller: cashBackController,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardAppearance: Brightness.dark,
                    showCursor: true,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  MainButtonWidget(
                    text: 'Оплата для товара',
                    method: () async {
                      await context
                          .read<PaymentClientViewModel>()
                          .payForGoods(cashBackController.text, code)
                          .then(
                            (value) => Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const PaymentSuccessView(),
                              ),
                              (route) => false,
                            ),
                          );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
