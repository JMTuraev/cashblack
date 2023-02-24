import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/balance.dart';
import '../../../domain/models/one_month_statistic.dart';
import '../../../domain/models/sum_cashback.dart';
import '../../../domain/models/user.dart';
import '../../../size_config.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../view_models/statistics_view_model.dart';
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
        title: const Text('Ваш баланс'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: Container(
        child: Column(
          children: [
            const _CashbackWidget(),
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
  late Future<List<SumCashback>> statsFuture;

  @override
  void initState() {
    myBalance = context.read<BusinessHomeViewModel>().getBalance();
    aWeekStats = context.read<BusinessHomeViewModel>().getStatistics();
    statsFuture = context.read<StatisticsViewModel>().getCashbackStats();

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
                  // const Text(
                  //   'Ваш баланс',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // const SizedBox(height: 14),
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
                          style: const TextStyle(fontSize: 25),
                        );
                      } else
                        return const Text(
                          '',
                          style: TextStyle(fontSize: 28),
                        );
                    },
                  ),
                  SizedBox(height: getH(18)),
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
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/add-square.svg',
                                    width: getW(20),
                                    height: getH(20),
                                  ),
                                  const Text(
                                    'Пополнить',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: getW(50)),
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
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/clock.svg',
                                    width: getW(20),
                                    height: getH(20),
                                  ),
                                  const Text(
                                    'История',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Center(child: SizedBox())
                ],
              ),
            ],
          ),
        ),
        // const SizedBox(height: 10),
        // const _LineInfoWidget(),
        Column(
          children: [
            FutureBuilder(
              future: statsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<SumCashback> data = snapshot.data as List<SumCashback>;
                  return Column(
                    children: [
                      const Text(
                        'Количество клиентов',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: getH(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/profile-2user.svg',
                            semanticsLabel: 'user',
                            color: Colors.white,
                            height: getH(24),
                            width: getW(24),
                          ),
                          SizedBox(width: getW(18)),
                          Text(
                            data.length.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
        SizedBox(height: getH(60)),
        SizedBox(
          height: getH(380),
          // height: MediaQuery.of(context).size.height / 3,
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
                        DateTime.now().subtract(const Duration(days: 7)),
                      );
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
        const SizedBox(height: 30),
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

class _ChartCashbackWidget extends StatefulWidget {
  _ChartCashbackWidget({
    Key? key,
    required this.aWeekStatistics,
    required this.maxSum,
  }) : super(key: key);

  final List<OneMonthStatistic> aWeekStatistics;
  final double maxSum;

  @override
  State<_ChartCashbackWidget> createState() => _ChartCashbackWidgetState();
}

class _ChartCashbackWidgetState extends State<_ChartCashbackWidget> {
  bool showSum = true;

  bool showCashback = true;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    const color1 = Color.fromRGBO(103, 206, 103, 1);
    const color2 = Color.fromRGBO(255, 144, 62, 1);

    LineChartBarData sumChartBarData = LineChartBarData(
      color: color1,
      isCurved: true,
      curveSmoothness: 0.2,
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
        // color: color1.withOpacity(0.3),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color1, color1.withOpacity(0.1)],
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
            strokeColor: color1.withOpacity(0.3),
          );
        },
      ),
      spots: showSum
          ? [
              ...widget.aWeekStatistics.map(
                (e) {
                  return FlSpot(
                    double.parse(
                      e.date!
                          .difference(
                            DateTime.now().subtract(const Duration(days: 7)),
                          )
                          .inDays
                          .abs()
                          .toString(),
                    ),
                    double.parse(e.price.toString()),
                  );
                },
              ),
            ]
          : [FlSpot.zero],
    );

    LineChartBarData cashbackChartBarData = LineChartBarData(
      color: color2,
      isCurved: true,
      curveSmoothness: 0.2,
      barWidth: 3,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color2, color2.withOpacity(0.1)],
        ),
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
            strokeColor: color2.withOpacity(0.3),
          );
        },
      ),
      spots: showCashback
          ? [
              ...widget.aWeekStatistics.map(
                (e) => FlSpot(
                  double.parse(
                    e.date!
                        .difference(
                          DateTime.now().subtract(const Duration(days: 7)),
                        )
                        .inDays
                        .abs()
                        .toString(),
                  ),
                  //TODO 5 ga ko'paydi!
                  double.parse(e.cashback.toString()) * 5,
                ),
              ),
            ]
          : [FlSpot.zero],
    );

    const boxShadow = [
      BoxShadow(
        color: Color.fromRGBO(255, 255, 255, 1),
        blurRadius: 4,
        offset: Offset(0, 0),
      ),
    ];
    return Column(
      children: [
        // const _LineInfoWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showSum = !showSum;
                  if (showCashback == false) {
                    showCashback = true;
                    showSum = true;
                  }
                });
              },
              child: Column(
                children: [
                  Text(
                    'Сумма',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: showSum ? color1 : color1.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(height: getH(10)),
                  Container(
                    decoration: BoxDecoration(
                      color: showSum ? color1 : color1.withOpacity(0.5),
                      boxShadow: boxShadow,
                    ),
                    height: getH(2),
                    width: getW(80),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            GestureDetector(
              onTap: () {
                setState(() {
                  showCashback = !showCashback;
                  if (showSum == false) {
                    showSum = true;
                    showCashback = true;
                  }
                });
              },
              child: Column(
                children: [
                  Text(
                    'Кэшбек',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: showCashback ? color2 : color2.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(height: getH(10)),
                  Container(
                    decoration: BoxDecoration(
                      color: showCashback ? color2 : color2.withOpacity(0.5),
                      boxShadow: boxShadow,
                    ),
                    height: getH(2),
                    width: getW(80),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 20,
            ),
            child: Container(
              child: LineChart(
                LineChartData(
                  maxY: widget.maxSum,
                  minY: -widget.maxSum / 10,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.grey[900],
                      showOnTopOfTheChartBoxArea: true,
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipItems: (touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          return barSpot.barIndex == 0
                              ? LineTooltipItem(
                                  NumberFormat.simpleCurrency(
                                    name: '',
                                    locale: 'ru_RU',
                                    decimalDigits: 0,
                                  ).format(barSpot.y),
                                  TextStyle(
                                    color: barSpot.bar.color,
                                    fontWeight: FontWeight.bold,
                                  ))
                              : LineTooltipItem(
                                  NumberFormat.simpleCurrency(
                                    name: '',
                                    locale: 'ru_RU',
                                    decimalDigits: 0,
                                  ).format(
                                    barSpot.y / 5,
                                  ),
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
                                  ? (value.toInt() / 1000).toStringAsFixed(0) +
                                      ' тыс'
                                  : '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                        showTitles: true,
                        interval: widget.maxSum != 0 ? (widget.maxSum / 2) : 1,
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
                                  widget.aWeekStatistics[value.toInt()].date!,
                                ),
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
                    ),
                  ),
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
