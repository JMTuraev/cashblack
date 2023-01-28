import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../view_models/business_home_view_model.dart';
import '../../../../view_models/business_login_view_model.dart';
import '../../../../widgets/hero_title_widget.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/small_title_widget.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../business_home_view/business_home_view.dart';
import '../../create_store_view/create_store_view.dart';

class BusinessLoginVerifyView extends StatefulWidget {
  const BusinessLoginVerifyView({Key? key}) : super(key: key);

  @override
  State<BusinessLoginVerifyView> createState() =>
      _BusinessLoginVerifyViewState();
}

class _BusinessLoginVerifyViewState extends State<BusinessLoginVerifyView>
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
                text: context.read<BusinessLoginViewModel>().phone,
              ),
              const SizedBox(height: 40),
              PinFieldAutoFill(
                controller: textController,
                autoFocus: true,
                codeLength: 5,
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
                  if (code!.length == 5) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
              ),
              const SizedBox(height: 20),
              TextButtonWidget(
                text: 'Не получили код. Отправить код еще раз',
                method: () {
                  _animationController!.reset();
                  _animationController!.forward();
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
                text: 'Подтвердить',
                method: () async {
                  await context
                      .read<BusinessHomeViewModel>()
                      .getProfile()
                      .then((value) async {
                    bool checked = await context
                        .read<BusinessLoginViewModel>()
                        .onVerifyButtonPressed(otpCode ?? textController.text);
                    bool hasShop = context
                        .read<BusinessHomeViewModel>()
                        .user!
                        .shops
                        .isNotEmpty;

                    checked
                        ? (hasShop
                            ? Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const BusinessHomeView(),
                                ),
                                (route) => false)
                            : Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(
                                  builder: (context) => const CreateStoreView(),
                                ),
                                (route) => false))
                        : null;
                  });
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
