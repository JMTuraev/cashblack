import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../size_config.dart';
import '../../../../view_models/business_login_view_model.dart';
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
      type: MaskAutoCompletionType.lazy);

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    var provider = context.read<BusinessLoginViewModel>();

    void submit() async {
      if (maskFormatter.isFill()) {
        var phone = maskFormatter.unmaskText(phoneController.text);

        var promo = promoCodeController.text;

        bool sendSMS = false;

        sendSMS = await provider.sendSms(
          phone,
          provider.appSignature = await SmsAutoFill().getAppSignature,
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
                  return InfoAlertWidget(
                      title: 'Это аккаунт клиента, проверьте номер телефона');
                },
              );
      }
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (text) {
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
                    print('check');
                  },
          ),
          SizedBox(height: getH(35)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: checked,
                  onChanged: (value) {
                    setState(() {
                      checked = value!;
                    });
                  }),
              Text(
                'Я принимаю',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              PublicOfferWidget(),
            ],
          ),
          ConnectWidget(),
        ],
      ),
    );
  }
}
