import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/balance.dart';
import '../../../domain/models/one_month_statistic.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../view_models/settings_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/screen_wrapper.dart';

import 'package:cashblack/extensions.dart';

import '../../select_type_view/select_type_view.dart';
import '../settings_view/payment_view.dart';
import '../settings_view/payments_history_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool isCashback = true;
  bool isGoods = false;

  @override
  void initState() {
    context.read<BusinessHomeViewModel>().getProfile();
    super.initState();
  }

  // DateTimeRange dateRange = DateTimeRange(
  //   start: DateTime.now(),
  //   end: DateTime.now(),
  // );

  // Future pickRange() async {
  //   DateTimeRange? dateRangePicker = await showDateRangePicker(
  //     context: context,
  //     initialDateRange: dateRange,
  //     firstDate: DateTime(2022),
  //     lastDate: DateTime(2023),
  //   );

  //   if (dateRangePicker == null) return;
  //   setState(() {
  //     dateRange = dateRangePicker;
  //   });
  // }

  String? _filter;

  onFilterChanged(value) {
    setState(() {
      _filter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cashback',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // centerTitle: true,
      ),
      // edge: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      body: Column(
        children: [
          // const SizedBox(height: 20),
          const _CashbackWidget(),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _CashbackWidget extends StatelessWidget {
  const _CashbackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxSum = 0;

    List<OneMonthStatistic> aWeekStatistics = [
      OneMonthStatistic(
        cashback: 0,
        price: 0,
        date: DateTime.now().subtract(const Duration(days: 6)),
      ),
      OneMonthStatistic(
        cashback: 0,
        price: 0,
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      OneMonthStatistic(
        cashback: 0,
        price: 0,
        date: DateTime.now().subtract(const Duration(days: 4)),
      ),
      OneMonthStatistic(
        cashback: 0,
        price: 0,
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
      OneMonthStatistic(
        cashback: 0,
        price: 0,
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
      OneMonthStatistic(
        cashback: 0,
        price: 0,
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      OneMonthStatistic(
        cashback: 0,
        price: 0,
        date: DateTime.now(),
      ),
    ];

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                children: [
                  const Text(
                    'Ваш баланс',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  FutureBuilder(
                    future: context.read<SettingsViewModel>().getBalance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print('sn   ' + snapshot.data.toString());
                        var balance = snapshot.data as List<Balance>;
                        return Text(
                          // balance.first.amount + ' UZS',

                          NumberFormat.simpleCurrency(
                                name: '',
                                locale: 'ru_RU',
                                decimalDigits: 0,
                              ).format(int.parse(balance.first.amount)) +
                              'UZS',
                          style: TextStyle(fontSize: 28),
                        );
                      } else
                        return Text(
                          '',
                          style: TextStyle(fontSize: 28),
                        );
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const PaymentView(),
                            ),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              CupertinoIcons.add_circled,
                              size: 30,
                            ),
                            Text('Пополнить'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const PaymentsHistoryView(),
                            ),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              CupertinoIcons.arrow_right_arrow_left_circle,
                              size: 30,
                            ),
                            Text('История'),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // Positioned(
              //   right: 0,
              //   child: GestureDetector(
              //     child: const Icon(Icons.logout),
              //     onTap: () async {
              //       await context.read<SettingsViewModel>().logout();
              //       Navigator.of(context).pushAndRemoveUntil(
              //         CupertinoPageRoute(
              //           builder: (context) => const SelectTypeView(),
              //         ),
              //         (route) => false,
              //       );
              //       // ScaffoldMessenger.of(context).showSnackBar(
              //       //   Helpers.customSnackBar('Logout'),
              //       // );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          width: double.infinity,
          child: FutureBuilder(
            future: context.watch<BusinessHomeViewModel>().getStatistics(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<OneMonthStatistic> stats =
                    snapshot.data as List<OneMonthStatistic>;
                // print('++++' + stats.toList().toString());

                if (stats.isNotEmpty) {
                  stats.forEach(
                    (e) {
                      // print('sana' + e.date.toString());
                      var dif = e.date?.difference(
                          DateTime.now().subtract(const Duration(days: 7)));
                      print('vaqti' + dif!.inDays.toString());
                      if (dif?.inDays != null) {
                        aWeekStatistics[(dif!.inDays.abs()).abs()] =
                            OneMonthStatistic(
                          cashback: e.cashback,
                          date: e.date,
                          price: e.price,
                        );
                        print('object ' + dif!.inDays.abs().toString());
                      }
                      if (double.parse(e.price.toString()) > maxSum) {
                        maxSum = double.parse(e.price.toString());
                        // print('maxsum' + maxSum.toString());
                      }
                    },
                  );

                  return _ChartCashbackWidget(
                    aWeekStatistics: aWeekStatistics,
                    maxSum: maxSum,
                  );
                } else {
                  return const EmptyWidget();
                }
              } else {
                return const EmptyWidget();
              }
            },
          ),
        ),
      ],
    );
  }
}

class _ChartCashbackWidget extends StatelessWidget {
  const _ChartCashbackWidget({
    Key? key,
    required this.aWeekStatistics,
    required this.maxSum,
  }) : super(key: key);

  final List<OneMonthStatistic> aWeekStatistics;
  final double maxSum;

  @override
  Widget build(BuildContext context) {
    // double maxSum = 0;
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    // List<OneMonthStatistic> aWeekStatistics = [
    //   OneMonthStatistic(
    //     cashback: 0,
    //     price: 0,
    //     date: DateTime.now().subtract(const Duration(days: 6)),
    //   ),
    //   OneMonthStatistic(
    //     cashback: 0,
    //     price: 0,
    //     date: DateTime.now().subtract(const Duration(days: 5)),
    //   ),
    //   OneMonthStatistic(
    //     cashback: 0,
    //     price: 0,
    //     date: DateTime.now().subtract(const Duration(days: 4)),
    //   ),
    //   OneMonthStatistic(
    //     cashback: 0,
    //     price: 0,
    //     date: DateTime.now().subtract(const Duration(days: 3)),
    //   ),
    //   OneMonthStatistic(
    //     cashback: 0,
    //     price: 0,
    //     date: DateTime.now().subtract(const Duration(days: 2)),
    //   ),
    //   OneMonthStatistic(
    //     cashback: 0,
    //     price: 0,
    //     date: DateTime.now().subtract(const Duration(days: 1)),
    //   ),
    //   OneMonthStatistic(
    //     cashback: 0,
    //     price: 0,
    //     date: DateTime.now(),
    //   ),
    // ];

    // stats.forEach(
    //   (e) {
    //     // print('sana' + e.date.toString());
    //     var dif = e.date
    //         ?.difference(DateTime.now().subtract(const Duration(days: 7)));
    //     print('vaqti' + dif!.inDays.toString());
    //     if (dif?.inDays != null) {
    //       aWeekStatistics[(dif!.inDays.abs()).abs()] = OneMonthStatistic(
    //         cashback: e.cashback,
    //         date: e.date,
    //         price: e.price,
    //       );
    //       print('object ' + dif!.inDays.abs().toString());
    //     }
    //     if (double.parse(e.price.toString()) > maxSum) {
    //       maxSum = double.parse(e.price.toString());
    //       // print('maxsum' + maxSum.toString());
    //     }
    //   },
    // );

    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        right: 20,
      ),
      child: Container(
        // color: Colors.red,
        // height: 300,
        // width: 300,
        child: LineChart(
          LineChartData(
            backgroundColor: Colors.grey.shade900,
            // minX: 0,
            // maxX: 6,
            // maxX: double.parse(stats.length.toString()) - 1,
            // minY: 0,
            maxY: maxSum,
            titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Text(
                          value.toInt() != 0
                              ? (value.toInt() / 1000).toStringAsFixed(0) +
                                  ' тыс'
                              : '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                    showTitles: true,
                    interval: maxSum != 0 ? (maxSum / 2) : 1,
                    reservedSize: 30,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        // padding: const EdgeInsets.all(8),
                        padding: const EdgeInsets.only(top: 20),
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(-45 / 360),
                          child: Text(
                            formatter
                                .format(aWeekStatistics[value.toInt()].date!),
                            // aWeekStatistics[value.toInt()].date.toString(),
                            // value.toInt().toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      );
                    },
                    showTitles: true,
                    interval: 1,
                    reservedSize: 40,
                  ),
                )
                // bottomTitles: AxisTitles(
                //   axisNameSize: 10,
                //   sideTitles: SideTitles(
                //     showTitles: true,
                //   ),
                // ),
                ),
            gridData: FlGridData(
              show: false,
            ),
            lineBarsData: [
              LineChartBarData(
                curveSmoothness: 0.1,
                color: Colors.blue,
                isCurved: true,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.3),
                ),
                spots: [
                  // ...stats.map(
                  //   (e) => FlSpot(
                  //       double.parse(e.date!
                  //           .difference(DateTime.now())
                  //           .inDays
                  //           .abs()
                  //           .toString()),
                  //       double.parse(e.price.toString())),
                  // ),
                  ...aWeekStatistics.map(
                    (e) {
                      print(double.parse(e.date!
                          .difference(DateTime.now())
                          .inDays
                          .abs()
                          .toString()));

                      return FlSpot(
                        double.parse(e.date!
                            .difference(DateTime.now()
                                .subtract(const Duration(days: 7)))
                            .inDays
                            .abs()
                            .toString()),
                        double.parse(e.price.toString()),
                      );
                    },
                  ),
                ],
              ),
              LineChartBarData(
                color: Colors.red,
                isCurved: true,
                curveSmoothness: 0.1,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.red.withOpacity(0.3),
                ),
                spots: [
                  // ...stats.map(
                  //   (e) => FlSpot(
                  //       double.parse(e.date!
                  //           .difference(DateTime.now())
                  //           .inDays
                  //           .abs()
                  //           .toString()),
                  //       double.parse(e.cashback.toString())),
                  // ),
                  ...aWeekStatistics.map(
                    (e) => FlSpot(
                        double.parse(e.date!
                            .difference(DateTime.now()
                                .subtract(const Duration(days: 7)))
                            .inDays
                            .abs()
                            .toString()),
                        double.parse(e.cashback.toString())),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
