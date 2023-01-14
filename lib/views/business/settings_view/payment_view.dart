import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../view_models/balance_view_model.dart';
import '../../../widgets/helpers.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';
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

    return ScreenWrapper(
        child: Form(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            MediumTitleWidget(text: 'Пополнить баланс'),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
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
            TextField(
              decoration: InputDecoration(
                hintText: 'ГГ/ММ',
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
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Сумма',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              // inputFormatters: [maskFormatter],
              controller: amountController,
              autocorrect: false,
              enableSuggestions: false,
              keyboardAppearance: Brightness.dark,
              showCursor: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            MainButtonWidget(
              text: 'Пополнить',
              method: () async {
                await context
                    .read<BalanceViewModel>()
                    .enterCardDetails(
                      maskFormatterCardName.getUnmaskedText(),
                      // '8600492931784702',
                      maskFormatterCardDate.getUnmaskedText(),
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
    ));
  }
}
