import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../string_extensions.dart';
import '../../../../size_config.dart';
import '../../../../view_models/client/client_login_view_model.dart';
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
  bool show = false;

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+### ## ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = context.read<ClientLoginViewModel>();

    void submit() async {
      print('submit');
      if (maskFormatter.isFill()) {
        var phone = maskFormatter.unmaskText(phoneController.text);
        print('phone');

        // bool sendSMS = false;

        // phone = '998973000225';

        bool sendSMS =
            await context.read<ClientLoginViewModel>().onEnterButtonPressed(
                  phone.substring(3),
                  'nickname',
                  'firstName',
                  'lastName',
                  '59',
                  'client',
                  '',
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
                    title: 'Это аккаунт сотрудника, проверьте номер телефона',
                  );
                },
              );
      }
    }

    return Form(
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
            isLoading: context.watch<ClientLoginViewModel>().isLoading,
            text: 'Вход',
            // method: () {
            //   if (_formKey.currentState!.validate()) {
            //     print('object1');
            //     context.watch<ClientLoginViewModel>().isLoading
            //         ? null
            //         : submit();
            //   }
            // },
            method: checked
                ? (context.watch<ClientLoginViewModel>().isLoading
                    ? null
                    : submit)
                : () {
                    setState(() {
                      show = true;
                    });
                  },
          ),
          SizedBox(height: getH(35)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: checked,
                activeColor: const Color.fromRGBO(52, 200, 90, 1),
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
    );
  }
}
