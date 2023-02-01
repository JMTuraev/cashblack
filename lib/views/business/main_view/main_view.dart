import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/balance.dart';
import '../../../domain/models/one_month_statistic.dart';
import '../../../domain/models/user.dart';
import '../../../theme/theme_details.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';
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
        title: const Text('Cashblack'),
        bottom: ThemeDetails.appBarDivider,
      ),
      body: Container(
        child: Column(
          children: [
            _CashbackWidget(),
          ],
        ),
      ),
    );
  }
}

class _CashbackWidget extends StatefulWidget {
  const _CashbackWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_CashbackWidget> createState() => _CashbackWidgetState();
}

class _CashbackWidgetState extends State<_CashbackWidget> {
  late final Future myBalance;
  late final Future aWeekStats;
  late User user;

  @override
  void initState() {
    myBalance = context.read<BusinessHomeViewModel>().getBalance();
    aWeekStats = context.read<BusinessHomeViewModel>().getStatistics();

    user = context.read<BusinessHomeViewModel>().user;

    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    // var user = context.watch<BusinessHomeViewModel>().user;
    // user = context.watch<BusinessHomeViewModel>().user;
    var isBusiness = user!.groups.first.name == 'Biznes';

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
                    future: myBalance,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Balance> balance = snapshot.data as List<Balance>;
                        return Text(
                          NumberFormat.simpleCurrency(
                                name: '',
                                locale: 'ru_RU',
                                decimalDigits: 0,
                              ).format(int.parse(balance.first.amount)) +
                              'сум',
                          style: const TextStyle(fontSize: 28),
                        );
                      } else
                        return const Text(
                          '',
                          style: TextStyle(fontSize: 28),
                        );
                    },
                  ),
                  const SizedBox(height: 10),
                  isBusiness
                      ? Row(
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
                                    builder: (context) =>
                                        const PaymentsHistoryView(),
                                  ),
                                );
                              },
                              child: Column(
                                children: const [
                                  Icon(
                                    CupertinoIcons
                                        .arrow_right_arrow_left_circle,
                                    size: 30,
                                  ),
                                  Text('История'),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Center(child: SizedBox())
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const _LineInfoWidget(),
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          width: double.infinity,
          child: FutureBuilder(
            future: aWeekStats,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<OneMonthStatistic> stats =
                    snapshot.data as List<OneMonthStatistic>;

                if (stats.length > 0) {
                  stats.forEach(
                    (e) {
                      var dif = e.date?.difference(
                          DateTime.now().subtract(const Duration(days: 7)));
                      if (dif?.inDays != null) {
                        aWeekStatistics[(dif!.inDays.abs()).abs()] =
                            OneMonthStatistic(
                          cashback: e.cashback,
                          date: e.date,
                          price: e.price,
                        );
                      }
                      if (double.parse(e.price.toString()) > maxSum) {
                        maxSum = double.parse(e.price.toString());
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
                return const LogoAnimatedWidget(
                  size: 1.5,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _LineInfoWidget extends StatelessWidget {
  const _LineInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const SizedBox(width: 4),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              height: 14,
              width: 22,
            ),
            const SizedBox(width: 4),
            const Text('Сумма'),
          ],
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              height: 14,
              width: 22,
            ),
            const SizedBox(width: 4),
            const Text('Кэшбек'),
          ],
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
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    LineChartBarData sumChartBarData = LineChartBarData(
      color: Colors.blue,
      isCurved: true,
      barWidth: 3,
      belowBarData: BarAreaData(
        show: true,
        applyCutOffY: true,
        cutOffY: 0,
        spotsLine: BarAreaSpotsLine(
          checkToShowSpotLine: (spot) {
            return spot.y > 0 ? true : false;
          },
        ),
        color: Colors.blue.withOpacity(0.3),
      ),
      dotData: FlDotData(
        show: true,
        checkToShowDot: (spot, barData) {
          return spot.y <= 0 ? false : true;
        },
        getDotPainter: (p0, p1, p2, p3) {
          return FlDotCirclePainter(
            radius: 3,
            color: Colors.white,
            strokeWidth: 1,
            strokeColor: Colors.blue.withOpacity(0.3),
          );
        },
      ),
      spots: [
        ...aWeekStatistics.map(
          (e) {
            return FlSpot(
              double.parse(e.date!
                  .difference(DateTime.now().subtract(const Duration(days: 7)))
                  .inDays
                  .abs()
                  .toString()),
              double.parse(e.price.toString()),
            );
          },
        ),
      ],
    );

    LineChartBarData cashbackChartBarData = LineChartBarData(
      color: Colors.red,
      isCurved: true,
      barWidth: 3,
      belowBarData: BarAreaData(
        show: true,
        color: Colors.red.withOpacity(0.3),
        applyCutOffY: true,
        cutOffY: 0,
        spotsLine: BarAreaSpotsLine(
          checkToShowSpotLine: (spot) {
            return spot.y > 0 ? true : false;
          },
        ),
      ),
      dotData: FlDotData(
        show: true,
        checkToShowDot: (spot, barData) {
          return spot.y <= 0 ? false : true;
        },
        getDotPainter: (p0, p1, p2, p3) {
          return FlDotCirclePainter(
            radius: 3,
            color: Colors.white,
            strokeWidth: 1,
            strokeColor: Colors.red.withOpacity(0.3),
          );
        },
      ),
      spots: [
        ...aWeekStatistics.map(
          (e) => FlSpot(
              double.parse(e.date!
                  .difference(DateTime.now().subtract(const Duration(days: 7)))
                  .inDays
                  .abs()
                  .toString()),
              double.parse(e.cashback.toString())),
        ),
      ],
    );

    return Column(
      children: [
        // const SizedBox(height: 10),
        // const _LineInfoWidget(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 0,
              right: 20,
            ),
            child: Container(
              child: LineChart(
                LineChartData(
                  maxY: maxSum,
                  minY: -maxSum / 10,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.grey[900],
                      showOnTopOfTheChartBoxArea: true,
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipItems: (touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          return LineTooltipItem(
                            NumberFormat.simpleCurrency(
                              name: '',
                              locale: 'ru_RU',
                              decimalDigits: 0,
                            ).format(barSpot.y),
                            TextStyle(
                              color: barSpot.bar.color,
                              fontWeight: FontWeight.bold,
                            ),
                            // children: [
                            //   TextSpan(
                            //     text: barSpot.y.toString(),
                            //     style: TextStyle(
                            //       color: Colors.blue[300],
                            //     ),
                            //   ),
                            //   TextSpan(
                            //     text: barSpot.y.toString(),
                            //     style: TextStyle(
                            //       color: Colors.red[300],
                            //     ),
                            //   ),
                            // ],
                          );
                        }).toList();
                      },
                    ),
                  ),
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
                                value.toInt() > 0
                                    ? (value.toInt() / 1000)
                                            .toStringAsFixed(0) +
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
                              padding: const EdgeInsets.only(
                                top: 30,
                              ),
                              child: RotationTransition(
                                turns: const AlwaysStoppedAnimation(-45 / 360),
                                child: Text(
                                  formatter.format(
                                      aWeekStatistics[value.toInt()].date!),
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
                          reservedSize: 60,
                        ),
                      )),
                  gridData: FlGridData(
                    show: true,
                    verticalInterval: 1,
                  ),
                  lineBarsData: [
                    sumChartBarData,
                    cashbackChartBarData,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
