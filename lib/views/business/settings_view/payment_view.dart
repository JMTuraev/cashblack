import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../extensions.dart';
import '../../../size_config.dart';
import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/main_button_widget.dart';

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
    type: MaskAutoCompletionType.lazy,
  );

  MaskTextInputFormatter maskFormatterCardDate = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пополнить баланс'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Image.asset(
                    //   'assets/images/card.png',
                    //   fit: BoxFit.contain,
                    //   height: MediaQuery.of(context).size.width / 1.5,
                    // ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getW(30),
                        vertical: getH(40),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey.shade700, Colors.black],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/sim.svg',
                            width: getW(48),
                          ),
                          SizedBox(height: getH(10)),
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 19) {
                                return 'Введите данные карты';
                              }
                              return null;
                            },
                            textAlign: TextAlign.start,
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
                              hintStyle: TextStyle(fontSize: 20),
                              hintText: '**** **** **** ****',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
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
                                  textAlign: TextAlign.start,
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
                                    hintText: 'ММ/ГГ',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
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
                                        int.parse(value.removeWhitespaces()) <
                                            10) {
                                      return 'Сумма меньше 500';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [numericTextFormatter],
                                  textAlign: TextAlign.start,
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
                                    hintText: 'Сумма',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    MainButtonWidget(
                      isLoading:
                          context.watch<BusinessHomeViewModel>().isLoading,
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
