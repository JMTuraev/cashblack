import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../view_models/balance_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import 'payment_verify_view.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    MaskTextInputFormatter maskFormatterCardName = MaskTextInputFormatter(
        mask: '#### #### #### ####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    MaskTextInputFormatter maskFormatterCardDate = MaskTextInputFormatter(
        mask: '##/##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    TextEditingController amountController = TextEditingController();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Пополнить баланс',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                // MediumTitleWidget(text: 'Пополнить баланс'),
                // const SizedBox(height: 20),
                Image.asset(
                  'assets/images/credit-card.png',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.width / 1.5,
                ),
                const SizedBox(height: 20),
                TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.credit_card),
                    hintText: '0000 0000 0000 0000',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  inputFormatters: [maskFormatterCardName],
                  // controller: phoneController,
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
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.calendar_month_outlined),
                          hintText: 'ММ/ГГ',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        inputFormatters: [maskFormatterCardDate],
                        // controller: phoneController,
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardAppearance: Brightness.dark,
                        showCursor: true,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Сумма',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        // inputFormatters: [],
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
                  text: 'Пополнить',
                  method: () async {
                    var eDate = maskFormatterCardDate.getUnmaskedText();
                    print(eDate);
                    var fixedDate = eDate[2] + eDate[3] + eDate[0] + eDate[1];
                    print(fixedDate);

                    await context
                        .read<BalanceViewModel>()
                        .enterCardDetails(
                          maskFormatterCardName.getUnmaskedText(),
                          // '8600492931784702',
                          fixedDate,
                          // '2608',
                          amountController.text,
                        )
                        .then(
                          (value) => Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => PaymentVerifyView(
                                cardNumber: value[0],
                                expireDate: value[1],
                                amount: value[2],
                                session: value[3],
                                phone: value[4],
                              ),
                            ),
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
