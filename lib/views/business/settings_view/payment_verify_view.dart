import 'package:cashblack/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../widgets/hero_title_widget.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/small_title_widget.dart';
import '../../../view_models/balance_view_model.dart';
import '../../../view_models/business_home_view_model.dart';
import '../scanner_view/payment_success_view.dart';

class PaymentVerifyView extends StatefulWidget {
  PaymentVerifyView({
    Key? key,
    required this.phone,
    required this.session,
    required this.cardNumber,
    required this.expireDate,
    required this.amount,
  }) : super(key: key);

  final String cardNumber;
  final String expireDate;
  final String amount;
  final String phone;
  final int session;

  @override
  State<PaymentVerifyView> createState() => _PaymentVerifyViewState();
}

class _PaymentVerifyViewState extends State<PaymentVerifyView>
    with CodeAutoFill, SingleTickerProviderStateMixin {
  String? appSignature;
  String? otpCode;

  AnimationController? _animationController;
  int levelClock = 60;

  final TextEditingController textController = TextEditingController();

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _animationController!.forward();

    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
        otpCode = code;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
    _animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.read<BusinessHomeViewModel>().isLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeroTitleWidget(
                text: 'Верификационный код',
              ),
              const SizedBox(height: 20),
              const SmallTitleWidget(
                text: 'СМС код отпавлен на номер',
              ),
              const SizedBox(height: 5),
              SmallTitleWidget(
                text: widget.phone.phoneFormatter(),
              ),
              const SizedBox(height: 40),
              PinFieldAutoFill(
                controller: textController,
                autoFocus: true,
                codeLength: 6,
                decoration: UnderlineDecoration(
                  gapSpace: 40,
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                  colorBuilder:
                      FixedColorBuilder(Colors.white.withOpacity(0.3)),
                ),
                currentCode: otpCode,
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  if (code!.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
              ),
              const SizedBox(height: 20),
              _Countdown(
                animation: StepTween(
                  begin: levelClock,
                  end: 0,
                ).animate(_animationController!),
              ),
              const SizedBox(height: 20),
              MainButtonWidget(
                isLoading: isLoading,
                text: 'Подтвердить',
                method: () async {
                  await context.read<BusinessHomeViewModel>().paymentConfirm(
                        context,
                        widget.cardNumber,
                        widget.expireDate,
                        widget.amount,
                        widget.session,
                        otpCode ?? textController.text,
                      );
                  // .then(
                  //   (value) => Navigator.of(context).pushAndRemoveUntil(
                  //     CupertinoPageRoute(
                  //       builder: (context) => const PaymentSuccessView(
                  //         title: 'Счет пополнено',
                  //       ),
                  //     ),
                  //     (route) => false,
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Countdown extends AnimatedWidget {
  _Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Center(
      child: Text(
        timerText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
