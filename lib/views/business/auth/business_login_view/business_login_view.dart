import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../view_models/business_login_view_model.dart';
import '../../../../widgets/info_alert_widget.dart';
import '../../../../widgets/public_offer_widget.dart';
import '../../../../widgets/small_title_widget.dart';
import '../business_login_verify_view/business_login_verify_view.dart';

class BusinessLoginView extends StatelessWidget {
  BusinessLoginView({super.key});

  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController promoCodeController = TextEditingController(text: '');
  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '+### ## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

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
          const SmallTitleWidget(
            text: 'Мы отправим вам код подтверждения',
          ),
          const SizedBox(height: 10),
          TextField(
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
                  Radius.circular(10),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
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
          _MainButtonWidget(
            text: 'Вход',
            method: context.watch<BusinessLoginViewModel>().isLoading
                ? null
                : submit,
          ),
          const SizedBox(height: 20),
          const PublicOfferWidget(),
        ],
      ),
    );
  }
}

class _MainButtonWidget extends StatelessWidget {
  const _MainButtonWidget({
    Key? key,
    required this.text,
    required this.method,
  }) : super(key: key);

  final String text;
  final VoidCallback? method;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: method,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(16),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
