import 'package:cashblack/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/barcode_scan.dart';
import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../view_models/payment_client_view_model.dart';
import '../../../widgets/logo_animated_widget.dart';
import '../../../widgets/main_button_widget.dart';
import 'payment_success_view.dart';

class PaymentClientView extends StatefulWidget {
  const PaymentClientView({
    Key? key,
    required this.code,
    required this.shopId,
  }) : super(key: key);

  final String code;
  final int shopId;

  @override
  State<PaymentClientView> createState() => _PaymentClientViewState();
}

class _PaymentClientViewState extends State<PaymentClientView> {
  late final Future profile;
  @override
  void initState() {
    profile = context
        .read<PaymentClientViewModel>()
        .getUserFromBarcode(widget.code, widget.shopId);
    super.initState();
  }

  TextEditingController priceController = TextEditingController();

  NumericTextFormatter numericTextFormatter = NumericTextFormatter();

  final _formKey = GlobalKey<FormState>();

  bool isWithdraw = false;

  String percent = '';

  @override
  Widget build(BuildContext context) {
    int cashbackPercentage =
        context.read<BusinessHomeViewModel>().user.shops.first.cashback;

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
                    print(snapshot.data.toString());
                    var user = snapshot.data as BarcodeScan;
                    return Column(
                      children: [
                        Text(
                          // 'asd',
                          user.datum.first.fullName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          // 'asd',
                          user.datum.first.userName.toString().phoneFormatter(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Все кэшбеки ' +
                              NumberFormat.simpleCurrency(
                                name: '',
                                locale: 'ru_RU',
                                decimalDigits: 0,
                              ).format(user.cashback) +
                              'сум',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLength: 12,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      if (value.isEmpty || value == null) {
                                        percent = '';
                                      } else {
                                        double a = double.parse(
                                                value.removeWhitespaces()) /
                                            cashbackPercentage;
                                        percent = a.toStringAsFixed(0);
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    // print('val ' + value.toString());
                                    if (value == null ||
                                        value.isEmpty ||
                                        int.parse(value.removeWhitespaces()) <=
                                            0) {
                                      print('Введите сумму');
                                      return 'Введите сумму';
                                    } else if (int.parse(
                                              value.removeWhitespaces(),
                                            ) >
                                            user.cashback.toInt() &&
                                        isWithdraw) {
                                      return 'Введите сумму меньше кэшбека';
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
                                    counterText: '',
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
                                        percent: percent.isEmpty
                                            ? null
                                            : int.parse(percent),
                                        text: 'Кэшбек',
                                        method: () async {
                                          isWithdraw = false;
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print('Кэшбек');
                                            print(isWithdraw);
                                            // return true;
                                            await context
                                                .read<PaymentClientViewModel>()
                                                .sendCashback(
                                                  priceController.text
                                                      .removeWhitespaces(),
                                                  widget.code,
                                                  widget.shopId,
                                                )
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
                                          isWithdraw = true;
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print('Оплата');
                                            print(isWithdraw);
                                            // return true;
                                            await context
                                                .read<PaymentClientViewModel>()
                                                .payForGoods(
                                                  priceController.text
                                                      .removeWhitespaces(),
                                                  widget.code,
                                                  widget.shopId,
                                                )
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
