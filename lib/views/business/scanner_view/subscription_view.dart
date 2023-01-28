import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../business_home_view/business_home_view.dart';
import '../settings_view/payment_view.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({
    Key? key,
    required this.isBusiness,
    // required this.title,
  }) : super(key: key);

  // final String title;
  final bool isBusiness;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Оплатите абонентскую плату',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  isBusiness
                      ? MainButtonWidget(
                          text: 'Пополнение баланса',
                          method: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => const PaymentView(),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      );
}
