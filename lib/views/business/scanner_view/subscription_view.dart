import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/business/business_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../settings_view/payment_view.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({
    Key? key,
    required this.isBusiness,
    required this.subscribtionPrice,
    required this.shopId,
  }) : super(key: key);

  final String subscribtionPrice;
  final bool isBusiness;
  final int shopId;

  @override
  Widget build(BuildContext context) {
    var balance = 12;
    bool isLoading = context.watch<BusinessViewModel>().isLoading;

    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Оплатите абонентскую плату',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$subscribtionPrice сум',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                isBusiness
                    ? int.parse('12') > int.parse(subscribtionPrice)
                        ? MainButtonWidget(
                            isLoading: isLoading,
                            text: 'Оплатить',
                            method: () async {
                              // await context
                              //     .read<BusinessHomeViewModel>()
                              //     .paySubscription(context, true);
                            },
                          )
                        : MainButtonWidget(
                            text: 'Пополнить баланс',
                            method: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => const PaymentView(),
                                ),
                              );
                            })
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
