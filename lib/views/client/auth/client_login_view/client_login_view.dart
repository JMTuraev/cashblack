import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../size_config.dart';
import '../../../../view_models/client_login_view_model.dart';
import '../../../../widgets/connect_widget.dart';
import '../../../../widgets/info_alert_widget.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/public_offer_widget.dart';
import '../client_login_verify_view/client_login_verify_view.dart';

class ClientLoginView extends StatefulWidget {
  ClientLoginView({super.key});

  @override
  State<ClientLoginView> createState() => _ClientLoginViewState();
}

class _ClientLoginViewState extends State<ClientLoginView> {
  TextEditingController phoneController = TextEditingController(text: '');

  bool checked = false;

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '+### ## ### ## ##',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    var provider = context.read<ClientLoginViewModel>();

    void submit() async {
      print('object');
      if (maskFormatter.isFill()) {
        var phone = maskFormatter.unmaskText(phoneController.text);
        print('object');

        bool sendSMS = false;

        sendSMS = await provider.sendSms(
          phone,
          provider.appSignature = await SmsAutoFill().getAppSignature,
        );
        sendSMS
            ? Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => ClientLoginVerifyView(
                    phone: phone,
                    appsign: provider.appSignature,
                  ),
                ),
              )
            : showCupertinoDialog(
                context: context,
                builder: (context) {
                  return const InfoAlertWidget(
                      title:
                          'Это аккаунт сотрудника, проверьте номер телефона');
                },
              );
      }
    }

    return Column(
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
            hintText: 'Телефон',
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
        MainButtonWidget(
          isLoading: context.watch<ClientLoginViewModel>().isLoading,
          text: 'Вход',
          method: checked
              ? (context.watch<ClientLoginViewModel>().isLoading
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
    );
  }
}
