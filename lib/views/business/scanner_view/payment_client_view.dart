import 'package:cashblack/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/payment_client_view_model.dart';
import '../../../widgets/logo_animated_widget.dart';
import '../../../widgets/main_button_widget.dart';
import 'payment_success_view.dart';

class PaymentClientView extends StatefulWidget {
  const PaymentClientView({
    Key? key,
    required this.code,
  }) : super(key: key);

  final String code;

  @override
  State<PaymentClientView> createState() => _PaymentClientViewState();
}

class _PaymentClientViewState extends State<PaymentClientView> {
  late final Future profile;
  @override
  void initState() {
    profile =
        context.read<PaymentClientViewModel>().getUserFromBarcode(widget.code);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                future: profile,
                // future: context
                //     .read<PaymentClientViewModel>()
                //     .getUserFromBarcode(widget.code),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var user = snapshot.data;
                    return Column(
                      children: [
                        Text(
                          // 'asd',
                          user['full_name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          // 'asd',
                          user['username'].toString().phoneFormatter(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Введите сумму';
                                    }
                                    return null;
                                  },
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await context
                                                .read<PaymentClientViewModel>()
                                                .sendCashback(
                                                    priceController.text
                                                        .removeWhitespaces(),
                                                    widget.code)
                                                .then(
                                                  (value) =>
                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          const PaymentSuccessView(
                                                        title:
                                                            'Кэшбек выплачено',
                                                      ),
                                                    ),
                                                    (route) => false,
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: MainButtonWidget(
                                        text: 'Оплата',
                                        method: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await context
                                                .read<PaymentClientViewModel>()
                                                .payForGoods(
                                                    priceController.text
                                                        .removeWhitespaces(),
                                                    widget.code)
                                                .then(
                                                  (value) =>
                                                      Navigator.of(context)
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
                                          }
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
                      child: const LogoAnimatedWidget(
                        size: 1.5,
                      ),
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
