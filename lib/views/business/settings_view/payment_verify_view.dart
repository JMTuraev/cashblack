// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../view_models/client_home_view_model.dart';
import '../../../../view_models/client_login_view_model.dart';
import '../../../../widgets/hero_title_widget.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/small_title_widget.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../../view_models/balance_view_model.dart';
import '../../client/client_home_view.dart/client_home_view.dart';

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
    print('update');
    setState(() {
      otpCode = code!;
      print(code);
      print(otpCode);
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeroTitleWidget(
                text: 'Verification Code',
              ),
              const SizedBox(height: 20),
              const SmallTitleWidget(
                text: 'Please type the verification code sent to',
              ),
              const SizedBox(height: 5),
              SmallTitleWidget(
                text: widget.phone,
              ),
              const SizedBox(height: 5),
              SmallTitleWidget(
                text: widget.session.toString(),
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
                    // color: Colors.white,
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
                  begin: levelClock, // THIS IS A USER ENTERED NUMBER
                  end: 0,
                ).animate(_animationController!),
              ),
              const SizedBox(height: 20),
              MainButtonWidget(
                text: 'Verify',
                method: () async {
                  // print(hasShop);
                  await context
                      .read<BalanceViewModel>()
                      .paymentConfirm(
                        widget.cardNumber,
                        widget.expireDate,
                        widget.amount,
                        widget.session,
                        otpCode ?? textController.text,
                      )
                      .then(
                        (value) => Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                            builder: (context) => const ClientHomeView(),
                          ),
                          (route) => false,
                        ),
                      );
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 32),
              //   child: Builder(
              //     builder: (_) {
              //       if (otpCode == null) {
              //         return _Countdown(
              //           animation: StepTween(
              //             begin: levelClock, // THIS IS A USER ENTERED NUMBER
              //             end: 0,
              //           ).animate(_animationController!),
              //         );
              //       }
              // return MainButtonWidget(
              //   text: 'Verify',
              //   method: () {
              //     Navigator.of(context).pushAndRemoveUntil(
              //         CupertinoPageRoute(
              //           builder: (context) => CreateStoreView(),
              //         ),
              //         (route) => false);
              //   },
              // );
              //     },
              //   ),
              // ),
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
