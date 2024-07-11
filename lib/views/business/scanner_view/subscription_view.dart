import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../string_extensions.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_notifications_view_model.dart';
import '../../../view_models/business/business_payment_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/show_modal.dart';
import 'payment_success_view.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({
    super.key,
    required this.isBusiness,
    required this.subscribtionPrice,
    required this.shopId,
  });

  final String subscribtionPrice;
  final bool isBusiness;
  final int shopId;

  @override
  Widget build(BuildContext context) {
    const balance = 12;
    final isLoading = context.watch<BusinessViewModel>().isLoading;

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
                          const Text(
                            'Баланс: ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                          const Text(
                            'Абонентская плата: ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                    ? double.parse(
                              context
                                  .read<BusinessSettingsViewModel>()
                                  .businessProfile!
                                  .balance,
                            ) >
                            double.parse(subscribtionPrice)
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
                                          const PaymentSuccessView(
                                        title: 'Оплачено',
                                      ),
                                    ),
                                  );
                                }
                                // Navigator.pop(context);
                              });
                            },
                          )
                        : MainButtonWidget(
                            isLoading: false,
                            text: 'Пополнить баланс',
                            method: () async {
                              // Navigator.of(context).push(
                              //   CupertinoPageRoute(
                              //     builder: (context) => const PaymentView(),
                              //   ),
                              // );

                              final bonusPrices = context
                                  .read<BusinessPaymentViewModel>()
                                  .bonusPrices;
                              // Navigator.of(context).push(
                              //   CupertinoPageRoute<dynamic>(
                              //     builder: (context) => const PaymentView(),
                              //   ),
                              // );
                              context
                                      .read<BusinessPaymentViewModel>()
                                      .isPriceLoading
                                  ? () {}
                                  : showModal(context, [
                                      Column(
                                        children: [
                                          const Text(
                                            'Пополнить счёт',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              // childAspectRatio: 3 / 1,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              mainAxisExtent: 100,
                                            ),
                                            itemCount: bonusPrices.length,
                                            itemBuilder: (
                                              BuildContext context,
                                              int index,
                                            ) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  await context
                                                      .read<
                                                          BusinessDashboardViewModel>()
                                                      .payment(
                                                        bonusPrices[index]
                                                            .id
                                                            .toString(),
                                                      )
                                                      .then(
                                                        (value) =>
                                                            Helpers.toWeb(
                                                          value,
                                                          'telegram',
                                                        ),
                                                      );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    // horizontal: 10,
                                                    vertical: 6,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black26,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        bonusPrices[index]
                                                            .amount
                                                            .getAmountInSum(),
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      double.parse(
                                                                bonusPrices[
                                                                        index]
                                                                    .bonus,
                                                              ) <
                                                              1
                                                          ? const SizedBox()
                                                          : Column(
                                                              children: [
                                                                Text(
                                                                  '+${bonusPrices[index].bonus.getAmountInSum()}',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .greenAccent,
                                                                  ),
                                                                ),
                                                                const Text(
                                                                  'бонус',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .greenAccent,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ]);
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
}
