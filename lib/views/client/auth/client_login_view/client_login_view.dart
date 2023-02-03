import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../view_models/client_login_view_model.dart';
import '../../../../widgets/public_offer_widget.dart';
import '../../../../widgets/small_title_widget.dart';
import '../client_login_verify_view/client_login_verify_view.dart';

class ClientLoginView extends StatelessWidget {
  const ClientLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController(text: '');
    var provider = context.read<ClientLoginViewModel>();
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
        mask: '+### ## ### ## ##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    void submit() async {
      if (maskFormatter.isFill()) {
        var phone = maskFormatter.unmaskText(phoneController.text);

        provider.sendSms(
          phone,
          provider.appSignature = await SmsAutoFill().getAppSignature,
        );
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ClientLoginVerifyView(
              phone: phone,
              appsign: provider.appSignature,
            ),
          ),
        );
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmallTitleWidget(text: 'Мы отправим вам код подтверждения'),
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
        _MainButtonWidget(
          text: 'Вход',
          method:
              context.watch<ClientLoginViewModel>().isLoading ? null : submit,
        ),
        const SizedBox(height: 20),
        const PublicOfferWidget(),
      ],
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
