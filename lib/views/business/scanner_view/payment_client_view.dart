import 'package:cashblack/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/payment_client_view_model.dart';
import '../../../widgets/logo_animated_widget.dart';
import '../../../widgets/main_button_widget.dart';
import 'payment_success_view.dart';

class PaymentClientView extends StatelessWidget {
  const PaymentClientView({
    Key? key,
    required this.code,
  }) : super(key: key);

  final String code;

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();

    NumericTextFormatter numericTextFormatter = NumericTextFormatter();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              FutureBuilder(
                future: context
                    .read<PaymentClientViewModel>()
                    .getUserFromBarcode(code),
                builder: (context, snapshot) {
                  // if (snapshot.hasData) {
                  if (true) {
                    var user = snapshot.data;
                    return Column(
                      children: [
                        Text(
                          'asd',
                          // user['full_name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'asd',
                          // user['username'].toString().phoneFormatter(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Form(
                            child: Column(
                              children: [
                                TextField(
                                  inputFormatters: [numericTextFormatter],
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    hintText: 'Сумма покупки',
                                    border: OutlineInputBorder(
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
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: MainButtonWidget(
                                        text: 'Кэшбек',
                                        method: () async {
                                          await context
                                              .read<PaymentClientViewModel>()
                                              .sendCashback(
                                                  priceController.text
                                                      .removeWhitespaces(),
                                                  code)
                                              .then(
                                                (value) => Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const PaymentSuccessView(
                                                      title: 'Кэшбек выплачено',
                                                    ),
                                                  ),
                                                  (route) => false,
                                                ),
                                              );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: MainButtonWidget(
                                        text: 'Оплата',
                                        method: () async {
                                          await context
                                              .read<PaymentClientViewModel>()
                                              .payForGoods(
                                                  priceController.text
                                                      .removeWhitespaces(),
                                                  code)
                                              .then(
                                                (value) => Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const PaymentSuccessView(
                                                      title: 'Оплачено',
                                                    ),
                                                  ),
                                                  (route) => false,
                                                ),
                                              );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.width,
                      child: const LogoAnimatedWidget(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
