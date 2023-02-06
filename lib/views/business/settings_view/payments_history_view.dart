import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/payment.dart';
import '../../../extensions.dart';
import '../../../theme/theme_details.dart';
import '../../../view_models/balance_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';

class PaymentsHistoryView extends StatefulWidget {
  const PaymentsHistoryView({super.key});

  @override
  State<PaymentsHistoryView> createState() => _PaymentsHistoryViewState();
}

class _PaymentsHistoryViewState extends State<PaymentsHistoryView> {
  late final Future historyFuture;

  @override
  void initState() {
    historyFuture = context.read<BalanceViewModel>().getPayments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy').add_Hm();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('История платежей'),
          bottom: ThemeDetails.appBarDivider,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: historyFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Payment> payments = snapshot.data as List<Payment>;

                      if (payments.length > 0) {
                        return ListView.separated(
                          itemCount: payments.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 1,
                              color: Colors.white54,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 6,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    (index + 1).toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        payments[index]
                                            .cardNumber
                                            .cardHiddenFormatter(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        payments[index]
                                            .date
                                            .getLocaleDateTime(),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        NumberFormat.simpleCurrency(
                                          name: '',
                                          locale: 'ru_RU',
                                          decimalDigits: 0,
                                        ).format(
                                            int.parse(payments[index].amount)),
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green[400],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const Text(
                                        'сум',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: EmptyWidget());
                      }
                    } else {
                      return const Center(child: LogoAnimatedWidget(size: 1.5));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
