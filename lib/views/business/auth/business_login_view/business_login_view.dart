import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../string_extensions.dart';
import '../../../../size_config.dart';
import '../../../../view_models/business/business_login_view_model.dart';
import '../../../../widgets/connect_widget.dart';
import '../../../../widgets/info_alert_widget.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/public_offer_widget.dart';
import '../business_login_verify_view/business_login_verify_view.dart';

class BusinessLoginView extends StatefulWidget {
  BusinessLoginView({super.key});

  @override
  State<BusinessLoginView> createState() => _BusinessLoginViewState();
}

class _BusinessLoginViewState extends State<BusinessLoginView> {
  TextEditingController phoneController = TextEditingController(text: '');

  TextEditingController promoCodeController = TextEditingController(text: '');

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+### ## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  bool checked = false;
  bool show = false;
  bool hasPromocode = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = context.read<BusinessLoginViewModel>();

    Future<void> submit() async {
      if (maskFormatter.isFill()) {
        var phone = maskFormatter.unmaskText(phoneController.text);

        var promo = promoCodeController.text;

        // phone = '998973000225';

        // bool sendSMS = false;

        bool sendSMS =
            await context.read<BusinessLoginViewModel>().onEnterButtonPressed(
                  phone.substring(3),
                  phone.substring(3),
                  phone.substring(3),
                  phone.substring(3),
                  '59',
                  'owner',
                  promo,
                );
        sendSMS
            ? Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => BusinessLoginVerifyView(
                    appsign: provider.appSignature,
                    phone: phone,
                    promo: promo,
                  ),
                ),
              )
            : showCupertinoDialog(
                context: context,
                builder: (context) {
                  return const InfoAlertWidget(
                    title: 'Это аккаунт клиента, проверьте номер телефона',
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
                hintText: "Телефон",
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
            SizedBox(
              height: 30,
              child: Center(
                child: show && maskFormatter.isFill()
                    ? const Text(
                        'Принимайте условия оферты',
                        style: TextStyle(color: Colors.red),
                      )
                    : const Text(''),
              ),
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
                          hintText: "Промокод",
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
