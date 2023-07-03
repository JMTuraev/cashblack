import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../string_extensions.dart';
import '../../../view_models/business/business_notifications_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../settings_view/payment_view.dart';
import 'payment_success_view.dart';

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

    final subPrice = context
        .read<BusinessNotificationsViewModel>()
        .prices
        .where(
          (element) => element.type == 'subscript' && element.month == 1,
        )
        .first
        .price;

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Баланс: ',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            context
                                .read<BusinessSettingsViewModel>()
                                .businessProfile!
                                .balance
                                .getAmountInSum(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Абонентская плата: ',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            subPrice.getAmountInSum(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
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
                              await context
                                  .read<BusinessSettingsViewModel>()
                                  .subscribe(13)
                                  .then((value) {
                                if (value) {
                                  context
                                      .read<BusinessSettingsViewModel>()
                                      .getOwnerProfile();
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          PaymentSuccessView(title: 'Оплачено'),
                                    ),
                                  );
                                }
                                // Navigator.pop(context);
                              });
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
