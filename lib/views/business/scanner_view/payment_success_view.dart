import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../business_view.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/success.png',
                    fit: BoxFit.contain,
                    width: getW(200),
                    height: getW(200),
                    color: const Color.fromRGBO(52, 200, 90, 1),
                  ),
                  SizedBox(height: getH(20)),
                  Center(child: MediumTitleWidget(text: title)),
                  const SizedBox(height: 20),
                  MainButtonWidget(
                    text: 'OK',
                    method: () {
                      context.read<BusinessViewModel>().onChange(0);
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) => BusinessView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
