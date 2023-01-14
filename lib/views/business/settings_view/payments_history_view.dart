import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/payment.dart';
import '../../../view_models/balance_view_model.dart';
import '../../../widgets/helpers.dart';
import '../../../widgets/hero_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';

class PaymentsHistoryView extends StatelessWidget {
  const PaymentsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy, hh:mm');

    return ScreenWrapper(
      child: Column(
        children: [
          const HeroTitleWidget(text: 'История платежей'),
          FutureBuilder(
            future: context.watch<BalanceViewModel>().getPayments(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Payment> payments = snapshot.data as List<Payment>;

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: payments.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        payments[index].amount,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        formatter.format(DateTime.parse(payments[index].date)),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      // onTap: () {},
                    );
                  },
                );
              } else
                return Text('');
            },
          ),
        ],
      ),
    );
  }
}
