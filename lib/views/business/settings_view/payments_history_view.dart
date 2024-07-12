import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../string_extensions.dart';
import '../../../view_models/business/business_settings_view_model.dart';

class PaymentsHistoryView extends StatefulWidget {
  const PaymentsHistoryView({super.key});

  @override
  State<PaymentsHistoryView> createState() => _PaymentsHistoryViewState();
}

class _PaymentsHistoryViewState extends State<PaymentsHistoryView> {
  @override
  void initState() {
    // historyFuture = context.read<BalanceViewModel>().getPayments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final payments = context
            .read<BusinessSettingsViewModel>()
            .businessProfile
            ?.licence
            .reversedBy((e) => e.createdAt)
            .toList() ??
        [];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('История платежей'),
          // bottom: ThemeDetails.appBarDivider,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: payments.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Color.fromRGBO(28, 28, 29, 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${payments[index].startAt.getLocaleDateWithoutYear()} - ${payments[index].endAt.getLocaleDateWithYear()}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                payments[index].createdAt.getLocaleDateTime(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // NumberFormat.simpleCurrency(
                                //   name: '',
                                //   locale: 'ru_RU',
                                //   decimalDigits: 0,
                                // ).format(
                                //   int.parse('123'),
                                // ),
                                payments[index].amount.getFormattedNumber(),
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // child: FutureBuilder(
                //   future: historyFuture,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       List<Payment> payments = snapshot.data as List<Payment>;
                //       if (payments.isNotEmpty) {

                //       } else {
                //         return const Center(child: EmptyWidget());
                //       }
                //     } else {
                //       return const Center(child: LogoAnimatedWidget(size: 1.5));
                //     }
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
