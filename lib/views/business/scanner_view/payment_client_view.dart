import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/barcode_scan.dart';
import '../../../string_extensions.dart';
import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../../view_models/payment_client_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';
import '../../../widgets/main_button_widget.dart';

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
    // profile = context
    //     .read<PaymentClientViewModel>()
    //     .getUserFromBarcode(widget.code, widget.shopId);
    super.initState();
  }

  TextEditingController priceController = TextEditingController();

  NumericTextFormatter numericTextFormatter = NumericTextFormatter();

  final _formKey = GlobalKey<FormState>();

  bool isWithdraw = false;

  String percent = '';

  @override
  Widget build(BuildContext context) {
    int cashbackPercentage = 0;

    bool isLoading = false;
    bool isSmallLoading = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оплата через QR'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    // 'fullname',
                    '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    // name
                    ''.toString().phoneFormatter(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Все кэшбеки ' + '0 ' + 'сум',
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
                                  double a =
                                      double.parse(value.removeWhitespace()) /
                                          100 *
                                          cashbackPercentage;
                                  percent = a.toStringAsFixed(0);
                                }
                              });
                            },
                            validator: (value) {
                              // print('val ' + value.toString());
                              if (value == null ||
                                  value.isEmpty ||
                                  int.parse(value.removeWhitespace()) <= 0) {
                                print('Введите сумму');
                                return 'Введите сумму';
                              } else if (int.parse(
                                        value.removeWhitespace(),
                                      ) >
                                      // user.cashback!.toInt()
                                      110 &&
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
                                  Radius.circular(20),
                                ),
                              ),
                              counterText: '',
                              hintText: 'Сумма покупки',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
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
                                  isLoading: isLoading,
                                  percent: percent.isEmpty
                                      ? null
                                      : int.parse(percent),
                                  text: 'Кэшбек',
                                  method: () async {
                                    isWithdraw = false;
                                    if (_formKey.currentState!.validate()) {
                                      print('Кэшбек');
                                      print(isWithdraw);
                                      // await context
                                      //     .read<
                                      //         PaymentClientViewModel>()
                                      //     .sendCashback(
                                      //       context,
                                      //       priceController.text
                                      //           .removeWhitespaces(),
                                      //       widget.code,
                                      //       widget.shopId,
                                      //     );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: MainButtonWidget(
                                  isLoading: isSmallLoading,
                                  text: 'Оплата',
                                  method: () async {
                                    isWithdraw = true;
                                    if (_formKey.currentState!.validate()) {
                                      print('Оплата');
                                      print(isWithdraw);
                                      // return true;
                                      // await context
                                      //     .read<
                                      //         PaymentClientViewModel>()
                                      //     .payForGoods(
                                      //       context,
                                      //       priceController.text
                                      //           .removeWhitespaces(),
                                      //       widget.code,
                                      //       widget.shopId,
                                      //     );
                                      // .then(
                                      //   (value) =>
                                      //       Navigator.of(context)
                                      //           .pushAndRemoveUntil(
                                      //     CupertinoPageRoute(
                                      //       builder: (context) =>
                                      //           const PaymentSuccessView(
                                      //         title: 'Оплачено',
                                      //       ),
                                      //     ),
                                      //     (route) => false,
                                      //   ),
                                      // );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
