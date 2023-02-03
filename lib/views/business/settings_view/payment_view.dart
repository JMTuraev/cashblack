import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../extensions.dart';
import '../../../theme/theme_details.dart';
import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/balance_view_model.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/info_alert_widget.dart';
import '../../../widgets/main_button_widget.dart';
import 'payment_verify_view.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final _formKey = GlobalKey<FormState>();

  NumericTextFormatter numericTextFormatter = NumericTextFormatter();
  MaskTextInputFormatter maskFormatterCardName = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  MaskTextInputFormatter maskFormatterCardDate = MaskTextInputFormatter(
      mask: '##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.read<BusinessHomeViewModel>().isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Пополнить баланс'),
        bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/cc.png',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.width / 1.5,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 19) {
                          return 'Введите данные карты';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
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
                        prefixIcon: Icon(Icons.credit_card),
                        hintText: '0000 0000 0000 0000',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      inputFormatters: [maskFormatterCardName],
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
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 5) {
                                return 'Введите';
                              }
                              return null;
                            },
                            textAlign: TextAlign.center,
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
                              hintText: 'ММ/ГГ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            inputFormatters: [maskFormatterCardDate],
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardAppearance: Brightness.dark,
                            showCursor: true,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.parse(value.removeWhitespaces()) < 10) {
                                return 'Сумма меньше 500';
                              }
                              return null;
                            },
                            inputFormatters: [numericTextFormatter],
                            textAlign: TextAlign.center,
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
                              hintText: 'Сумма',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            controller: amountController,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardAppearance: Brightness.dark,
                            showCursor: true,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MainButtonWidget(
                      isLoading: isLoading,
                      text: 'Пополнить',
                      method: () async {
                        if (_formKey.currentState!.validate()) {
                          var eDate = maskFormatterCardDate.getUnmaskedText();
                          var fixedDate =
                              eDate[2] + eDate[3] + eDate[0] + eDate[1];

                          await context
                              .read<BusinessHomeViewModel>()
                              .enterCardDetails(
                                context,
                                maskFormatterCardName.getUnmaskedText(),
                                fixedDate,
                                amountController.text.removeWhitespaces(),
                              );
                          //     .then(
                          //   (value) {
                          //     if (value[0] == 'error_miqdor') {
                          //       showCupertinoDialog(
                          //         context: context,
                          //         builder: (context) {
                          //           return InfoAlertWidget(
                          //             title:
                          //                 'Сумма должен быт больше ${context.read<BusinessHomeViewModel>().balance.first.balanceShop.subscriptionPrice}',
                          //           );
                          //         },
                          //       );
                          //       return true;
                          //     } else if (value[0] ==
                          //         'Неправильные входные данные') {
                          //       showCupertinoDialog(
                          //         context: context,
                          //         builder: (context) {
                          //           return const InfoAlertWidget(
                          //             title: 'Неправильные входные данные',
                          //           );
                          //         },
                          //       );
                          //       return true;
                          //     } else if (value[0] == 'xato') {
                          //       showCupertinoDialog(
                          //         context: context,
                          //         builder: (context) {
                          //           return const InfoAlertWidget(
                          //             title: 'Попробуйте позже',
                          //           );
                          //         },
                          //       );
                          //       return true;
                          //     }
                          //     return Navigator.of(context).push(
                          //       CupertinoPageRoute(
                          //         builder: (context) => PaymentVerifyView(
                          //           cardNumber: value[0],
                          //           expireDate: value[1],
                          //           amount: value[2],
                          //           session: value[3],
                          //           phone: value[4],
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
