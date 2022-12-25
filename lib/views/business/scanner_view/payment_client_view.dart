import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/helpers.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';
import 'payment_success_view.dart';

class PaymentClientView extends StatelessWidget {
  const PaymentClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        child: Form(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            MediumTitleWidget(text: 'Начисление'),
            const SizedBox(height: 20),
            Text(
              'Klient Ism Familiya',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text('1234567890123'),
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
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PaymentSuccessView(),
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
