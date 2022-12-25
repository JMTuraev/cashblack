import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../widgets/helpers.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';

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
                hintText: 'MM/DD',
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
                hintText: 'Summa',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              // inputFormatters: [maskFormatter],
              // controller: phoneController,
              autocorrect: false,
              enableSuggestions: false,
              keyboardAppearance: Brightness.dark,
              showCursor: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            MainButtonWidget(
              text: 'Пополнить',
              method: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(Helpers.customSnackBar('UzCard API'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
