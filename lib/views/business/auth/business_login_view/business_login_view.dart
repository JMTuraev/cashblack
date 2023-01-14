import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../view_models/business_login_view_model.dart';
import '../../../../widgets/hero_title_widget.dart';
import '../../../../widgets/small_title_widget.dart';
import '../business_login_verify_view/business_login_verify_view.dart';

class BusinessLoginView extends StatelessWidget {
  const BusinessLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController(text: '');
    TextEditingController promoCodeController = TextEditingController(text: '');
    var provider = context.read<BusinessLoginViewModel>();
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
          // TODO appsign
          provider.appSignature = 'tempapp1',
          promoCodeController.text,
        );
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => const BusinessLoginVerifyView(),
          ),
        );
      }
    }

    // TODO promo kerak

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
              text: 'Мы отправим вам код подтверждения',
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: false,
                // hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Телефон",
                // fillColor: Colors.white70,
              ),
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
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: false,
                // hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Промокод",
                // fillColor: Colors.white70,
              ),
              controller: promoCodeController,
              autocorrect: false,
              autofocus: true,
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
            _PublicOfferWidget(),
            // _NumbersWidget(phoneController: phoneController),
          ],
        ),
      ),
    );
  }
}

class _PublicOfferWidget extends StatelessWidget {
  const _PublicOfferWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            // enableDrag: true,
            context: context,
            builder: (context) {
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  children: [
                    SizedBox(height: 6),
                    Text(
                      'Public offer',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Text(
          'Публичная оферта',
        ),
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
