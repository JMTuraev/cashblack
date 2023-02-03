import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/payment_client_view_model.dart';
import '../../../widgets/main_button_widget.dart';

import '../../../extensions.dart';
import '../business_home_view/business_home_view.dart';
import 'payment_success_view.dart';

class PaymentPhoneView extends StatelessWidget {
  PaymentPhoneView({
    super.key,
    required this.shopId,
  });

  final int shopId;

  final _formKey = GlobalKey<FormState>();

  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+### ## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  NumericTextFormatter numericTextFormatter = NumericTextFormatter();

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<PaymentClientViewModel>().isLoading;

    void submit() async {
      if (_formKey.currentState!.validate()) {
        await context.read<PaymentClientViewModel>().payPhone(
            context,
            priceController.text.removeWhitespaces(),
            maskFormatter.getUnmaskedText(),
            shopId);
        // isLoading = true;
        // await context
        //     .read<PaymentClientViewModel>()
        //     .sendCashbackWithPhone(
        //       priceController.text.removeWhitespaces(),
        //       maskFormatter.getUnmaskedText(),
        //       shopId,
        //     )
        //     .then(
        //   (value) {
        //     isLoading = false;
        //     return Navigator.of(context).pushAndRemoveUntil(
        //       CupertinoPageRoute(
        //         builder: (context) => const PaymentSuccessView(
        //           title: 'Оплачено',
        //         ),
        //       ),
        //       (route) => false,
        //     );
        //   },
        // );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оплата по номеру'),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cc.png',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.width / 2.5,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.parse(value.removeWhitespaces()) <= 0) {
                          return 'Введите номер телефона';
                        }
                        return null;
                      },
                      controller: phoneController,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: false,
                        hintText: "Телефон",
                      ),
                      inputFormatters: [maskFormatter],
                      autocorrect: false,
                      autofocus: true,
                      enableSuggestions: false,
                      keyboardAppearance: Brightness.dark,
                      showCursor: true,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.parse(value.removeWhitespaces()) <= 0) {
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
                    MainButtonWidget(
                      isLoading: isLoading,
                      text: 'OK',
                      method: submit,
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
