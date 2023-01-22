import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/payment.dart';
import '../../../theme/theme_details.dart';
import '../../../view_models/balance_view_model.dart';
import '../../../widgets/helpers.dart';
import '../../../widgets/hero_title_widget.dart';

import 'package:cashblack/extensions.dart';

class PaymentsHistoryView extends StatelessWidget {
  const PaymentsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy, hh:mm');

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
                  future: context.watch<BalanceViewModel>().getPayments(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Payment> payments = snapshot.data as List<Payment>;

                      return ListView.separated(
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
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
                              horizontal: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      payments[index]
                                          .cardNumber
                                          .cardHiddenFormatter(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      formatter.format(
                                        DateTime.parse(payments[index].date),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                    name: '',
                                    locale: 'ru_RU',
                                    decimalDigits: 0,
                                  ).format(int.parse(payments[index].amount)),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green[400],
                                  ),
                                ),

                                // ListTile(
                                //   title: Row(
                                //     children: [
                                //       Text(
                                //         payments[index].cardNumber.cardHiddenFormatter(),
                                //         style: TextStyle(
                                //           fontSize: 18,
                                //         ),
                                //       ),
                                //       Spacer(),
                                //       Text(
                                //         // payments[index].amount,
                                //         NumberFormat.simpleCurrency(
                                //           name: '',
                                //           locale: 'ru_RU',
                                //           decimalDigits: 0,
                                //         ).format(int.parse(payments[index].amount)),
                                //         style: TextStyle(
                                //           fontSize: 18,
                                //           color: Colors.green[400],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                //   subtitle: Text(formatter
                                //       .format(DateTime.parse(payments[index].date))),
                                //   contentPadding: const EdgeInsets.all(0),
                                //   // onTap: () {},
                                // ),
                              ],
                            ),
                          );
                        },
                      );
                    } else
                      return Text('');
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
