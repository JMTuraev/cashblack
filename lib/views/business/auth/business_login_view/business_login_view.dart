import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../../size_config.dart';
import '../../../../string_extensions.dart';
import '../../../../view_models/business/business_login_view_model.dart';
import '../../../../widgets/connect_widget.dart';
import '../../../../widgets/info_alert_widget.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/public_offer_widget.dart';
import '../business_login_verify_view/business_login_verify_view.dart';

class BusinessLoginView extends StatefulWidget {
  const BusinessLoginView({super.key});

  @override
  State<BusinessLoginView> createState() => _BusinessLoginViewState();
}

class _BusinessLoginViewState extends State<BusinessLoginView> {
  TextEditingController phoneController = TextEditingController(text: '+998');

  TextEditingController promoCodeController = TextEditingController(text: '');

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+998 ## ### ## ##',
    filter: {'#': RegExp('[0-9]')},
  );

  bool checked = false;
  bool show = false;
  bool hasPromocode = false;
  bool isSeller = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BusinessLoginViewModel>();
    if (phoneController.text.length < 3) {
      phoneController.text = '+998';
    }

    Future<void> submit() async {
      if (maskFormatter.isFill()) {
        final phone = maskFormatter.unmaskText(phoneController.text);

        final promo = promoCodeController.text;

        // phone = '998973000225';

        // bool sendSMS = false;

        final sendSMS =
            await context.read<BusinessLoginViewModel>().onEnterButtonPressed(
                  phone,
                  phone,
                  'Имя',
                  'Фамилия',
                  '59',
                  isSeller ? 'seller' : 'owner',
                  promo,
                );
        print(sendSMS);
        sendSMS == 'true'
            ? Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => BusinessLoginVerifyView(
                    appsign: provider.appSignature,
                    phone: phone,
                    promo: promo,
                    typeUser: isSeller ? 'seller' : 'owner',
                  ),
                ),
              )
            : showCupertinoDialog(
                context: context,
                builder: (context) {
                  return InfoAlertWidget(
                    title: sendSMS == 'sms_error'
                        ? 'Ошибка при отправке СМС, попробуйте позже'
                        : (sendSMS == 'type_error'
                            ? 'Это аккаунт клиента, проверьте номер телефона'
                            : 'Сервер недоступен, попробуйте позже'),
                  );
                },
              );
      }
    }

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.parse(value.removeWhitespace()) <= 0) {
                  return 'Введите номер телефона';
                }
                return null;
              },
              onChanged: (text) {
                setState(() {
                  show = false;
                });
                if (text.length == 17) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: false,
                hintText: '+998',
              ),
              inputFormatters: [maskFormatter],
              controller: phoneController,
              autocorrect: false,
              // autofocus: true,
              enableSuggestions: false,
              keyboardAppearance: Brightness.dark,
              showCursor: true,
              keyboardType: TextInputType.phone,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: const Color.fromRGBO(52, 200, 90, 1),
                  value: isSeller,
                  onChanged: (value) {
                    setState(() {
                      isSeller = value!;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSeller = !isSeller;
                    });
                  },
                  child: const Text(
                    'Сотрудник?',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            MainButtonWidget(
              text: 'Вход',
              isLoading: context.watch<BusinessLoginViewModel>().isLoading,
              // method: context.watch<BusinessLoginViewModel>().isLoading
              //     ? null
              //     : submit,
              method: checked
                  ? (context.watch<BusinessLoginViewModel>().isLoading
                      ? null
                      : submit)
                  : () {
                      setState(() {
                        show = true;
                      });
                    },
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              // height: 30,
              child: Center(
                child: show && maskFormatter.isFill()
                    ? const Text(
                        'Принимайте условия оферты',
                        style: TextStyle(color: Colors.red),
                      )
                    : const Text(' '),
              ),
            ),
            SizedBox(
              height: getH(35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        hasPromocode = !hasPromocode;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Есть промокод?'),
                        Icon(
                          hasPromocode == false
                              ? Icons.keyboard_arrow_down_sharp
                              : Icons.keyboard_arrow_up_sharp,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            hasPromocode == true
                ? Column(
                    children: [
                      SizedBox(height: getH(20)),
                      TextField(
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: false,
                          hintText: 'Промокод',
                        ),
                        controller: promoCodeController,
                        autocorrect: false,
                        // autofocus: true,
                        enableSuggestions: false,
                        keyboardAppearance: Brightness.dark,
                        showCursor: true,
                      ),
                    ],
                  )
                : const SizedBox(),
            // SizedBox(height: getH(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: const Color.fromRGBO(52, 200, 90, 1),
                  value: checked,
                  onChanged: (value) {
                    setState(() {
                      checked = value!;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      checked = !checked;
                    });
                  },
                  child: const Text(
                    'Я принимаю',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const PublicOfferWidget(),
              ],
            ),
            const ConnectWidget(),
          ],
        ),
      ),
    );
  }
}
