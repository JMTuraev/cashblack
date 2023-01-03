import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../view_models/client_login_view_model.dart';
import '../../../../widgets/hero_title_widget.dart';
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
        // await
        provider.sendSms(
          maskFormatter.unmaskText(phoneController.text),
          // provider.appSignature = await SmsAutoFill().getAppSignature,
          provider.appSignature = 'tempapp1',
        );
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => const ClientLoginVerifyView(),
          ),
        );
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeroTitleWidget(text: 'Введите номер телефона'),
            const SizedBox(height: 20),
            const SmallTitleWidget(
                text: 'We will send you the verification code'),
            const SizedBox(height: 20),
            TextField(
              inputFormatters: [maskFormatter],
              controller: phoneController,
              autocorrect: false,
              autofocus: true,
              enableSuggestions: false,
              keyboardAppearance: Brightness.dark,
              showCursor: true,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            _MainButtonWidget(
              text: 'Register',
              method: context.watch<ClientLoginViewModel>().isLoading
                  ? null
                  : submit,
            ),
            const SizedBox(height: 20),
            // _NumbersWidget(phoneController: phoneController),
          ],
        ),
      ),
    );
  }
}

class _NumbersWidget extends StatelessWidget {
  const _NumbersWidget({
    Key? key,
    required this.phoneController,
  }) : super(key: key);

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              child: const Text('1'),
              onPressed: () {
                phoneController.text += '1';
                print(phoneController.value);
              },
            ),
            ElevatedButton(onPressed: () {}, child: const Text('2')),
            ElevatedButton(onPressed: () {}, child: const Text('3')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('4')),
            ElevatedButton(onPressed: () {}, child: const Text('5')),
            ElevatedButton(onPressed: () {}, child: const Text('6')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('7')),
            ElevatedButton(onPressed: () {}, child: const Text('8')),
            ElevatedButton(onPressed: () {}, child: const Text('9')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('+')),
            ElevatedButton(onPressed: () {}, child: const Text('0')),
            ElevatedButton(
                onPressed: () {}, child: const Icon(CupertinoIcons.back)),
          ],
        ),
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
