import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/owner/weekly_stat.dart';
import '../../../size_config.dart';
import '../../../string_extensions.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_payment_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../view_models/business/business_statistics_view_model.dart';
import '../../../widgets/logo_animated_widget.dart';
import '../../../widgets/show_modal.dart';
import '../create_company_view.dart';
import '../create_store_view/create_store_view.dart';
import '../create_store_view/edit_store_view.dart';
import '../settings_view/payment_view.dart';
import '../settings_view/payments_history_view.dart';

class BusinessDashboardView extends StatefulWidget {
  const BusinessDashboardView({super.key});

  @override
  State<BusinessDashboardView> createState() => _BusinessDashboardViewState();
}

class _BusinessDashboardViewState extends State<BusinessDashboardView> {
  bool isCashback = true;
  bool isGoods = false;

  String? _filter;

  void onFilterChanged(String value) {
    setState(() {
      _filter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Ваш баланс'),
      //   // bottom: ThemeDetails.appBarDivider,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            _CashbackWidget(),
            // Expanded(
            //   child: ListView.separated(
            //     // shrinkWrap: true,
            //     itemCount: 10,
            //     // physics: NeverScrollableScrollPhysics(),
            //     separatorBuilder: (context, index) {
            //       return SizedBox(height: 10);
            //     },
            //     itemBuilder: (context, index) {
            //       return Text('data');
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _CashbackWidget extends StatefulWidget {
  const _CashbackWidget();

  @override
  State<_CashbackWidget> createState() => _CashbackWidgetState();
}

class _CashbackWidgetState extends State<_CashbackWidget> {
  // late final Future myBalance;
  // late final Future aWeekStats;
  // late User user;
  // late Future<List<SumCashback>> statsFuture;

  @override
  void initState() {
    super.initState();
  }

  double maxSum = 0;
  int currentShopIndex = 0;

  List<WeeklyStat> dummyWeekStatistics = [
    WeeklyStat(
      cashback: 0,
      totalCashback: 0,
      withdraw: 0,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    WeeklyStat(
      cashback: 0,
      totalCashback: 0,
      withdraw: 0,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    WeeklyStat(
      cashback: 0,
      totalCashback: 0,
      withdraw: 0,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    WeeklyStat(
      cashback: 0,
      totalCashback: 0,
      withdraw: 0,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    WeeklyStat(
      cashback: 0,
      totalCashback: 0,
      withdraw: 0,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    WeeklyStat(
      cashback: 0,
      totalCashback: 0,
      withdraw: 0,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    WeeklyStat(
      cashback: 0,
      totalCashback: 0,
      withdraw: 0,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // var user = context.watch<BusinessHomeViewModel>().user;
    // user = context.watch<BusinessHomeViewModel>().user;
    // var isBusiness = user!.groups.first.name == 'Biznes';

    final businessShops =
        context.read<BusinessDashboardViewModel>().businessShops!;
    final profile = context.read<BusinessSettingsViewModel>().businessProfile;
    return Container(
      // header: const CupertinoHeader(),
      // onRefresh: () {
      //   context.read<BusinessDashboardViewModel>().getBusinessShops();
      // },
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: getH(10)),
            height: getH(85),
            // width: double.infinity,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (context.read<BusinessDashboardViewModel>().hasCompany) {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const CreateStoreView(),
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const CreateCompanyView(),
                        ),
                      );
                    }
                  },
                  child: const _AddStoreWidget(),
                ),
                const SizedBox(width: 10),
                context.read<BusinessDashboardViewModel>().hasCompany
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const CreateCompanyView(),
                            ),
                          );
                        },
                        child: const FittedBox(
                          child: Text(
                            'У вас нет компания.\nСоздать компанию?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                context.watch<BusinessDashboardViewModel>().isGettingShops
                    ? const CupertinoActivityIndicator()
                    : (businessShops.isEmpty &&
                            context
                                .read<BusinessDashboardViewModel>()
                                .hasCompany
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => const CreateStoreView(),
                                ),
                              );
                            },
                            child: const FittedBox(
                              child: Text(
                                'У вас нет магазинов.\nСоздать магазин?',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: businessShops.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 10);
                              },
                              itemBuilder: (context, index) {
                                final shop = businessShops[index];
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<BusinessDashboardViewModel>()
                                        .getWeeklyStatistics(shop.id);
                                    setState(() {
                                      currentShopIndex = index;
                                    });
                                  },
                                  child: Container(
                                    height: getH(65),
                                    width: getH(65),
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //   color: currentShopIndex == index
                                      //       ? const Color(0xff67ce67)
                                      //       : Colors.black,
                                      //   width: 3,
                                      // ),
                                      border: currentShopIndex == index
                                          ? GradientBoxBorder(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Colors.green.shade500,
                                                  Colors.orange.shade500,
                                                ],
                                              ),
                                              width: 3,
                                            )
                                          : Border.all(
                                              width: 3,
                                            ),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          // offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: businessShops[index].logo != null
                                        ? ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  businessShops[index].logo!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : ClipOval(
                                            child: Container(
                                              // color: Color(
                                              //   (math.Random().nextDouble() * 0xFFFF11)
                                              //       .toInt(),
                                              // ).withOpacity(1),
                                              color: Colors.black38,
                                              alignment: Alignment.center,
                                              child: Text(
                                                shop.name.substring(0, 1),
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                            // child: Image.asset(
                                            //   'assets/images/notification/ak-1.png',
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          )),
              ],
            ),
          ),
          Column(
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => EditStoreView(
                        shop: businessShops[currentShopIndex],
                      ),
                    ),
                  );
                },
                child: Text(
                  businessShops.isNotEmpty
                      ? businessShops[currentShopIndex].name
                      : '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // const SizedBox(height: 14),
              // const Text(
              //   'Ваш баланс',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // const SizedBox(height: 14),

              // SizedBox(height: getH(18)),
              //TODO apple
              // 1 == 1

              !context.watch<BusinessSettingsViewModel>().isLoading
                  ? Column(
                      children: [
                        profile!.status == 1
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                    itemCount:
                                                        bonusPrices.length,
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
                                                                bonusPrices[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                              )
                                                              .then(
                                                                (value) =>
                                                                    Helpers
                                                                        .toWeb(
                                                                  value,
                                                                  'telegram',
                                                                ),
                                                              );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            // horizontal: 10,
                                                            vertical: 6,
                                                          ),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Colors.black26,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                10,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                bonusPrices[
                                                                        index]
                                                                    .amount
                                                                    .getAmountInSum(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              double.parse(
                                                                        bonusPrices[index]
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
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.greenAccent,
                                                                          ),
                                                                        ),
                                                                        const Text(
                                                                          'бонус',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.greenAccent,
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
                                        CupertinoPageRoute<dynamic>(
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
                            : const Center(child: SizedBox()),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(height: getH(10)),
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
                    context
                            .watch<BusinessStatisticsViewModel>()
                            .isClientsLoading
                        ? ' '
                        : context
                            .read<BusinessStatisticsViewModel>()
                            .clients
                            .length
                            .toString(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // _LineInfoWidget(),
          SizedBox(
            // width: 300,
            height: getW(300),
            child: context.watch<BusinessDashboardViewModel>().isWeeklyLoading
                ? const LogoAnimatedWidget(size: 1)
                : (context
                        .watch<BusinessDashboardViewModel>()
                        .weeklyStatistics
                        .isEmpty
                    ? _ChartCashbackWidget(
                        aWeekStatistics: dummyWeekStatistics,
                        maxSum:
                            context.read<BusinessDashboardViewModel>().maxSum,
                      )
                    : _ChartCashbackWidget(
                        aWeekStatistics: context
                            .read<BusinessDashboardViewModel>()
                            .weeklyStatistics,
                        maxSum:
                            context.read<BusinessDashboardViewModel>().maxSum,
                      )),
          ),
        ],
      ),
    );

    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: getH(65),
                width: getH(65),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: const Color(0x0cffffff),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x5effffff),
                      blurRadius: 21,
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff67ce67),
                      Color(0xffb0fab0),
                    ],
                  ),
                ),
                child: const Icon(Icons.add),
              ),
              SizedBox(width: getW(20)),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => const Text('asd'),
                ),
              ),
              // ListView.separated(
              //   scrollDirection: Axis.horizontal,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       height: getH(65),
              //       width: getH(65),
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: const Color(0xff67ce67),
              //         ),
              //         borderRadius: BorderRadius.circular(50),
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.withOpacity(0.5),
              //             spreadRadius: 1,
              //             blurRadius: 1,
              //             // offset: Offset(0, 0),
              //           )
              //         ],
              //       ),
              //       child: ClipOval(
              //         child: Image.asset(
              //           'assets/images/notification/ak-1.png',
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     );
              //   },
              //   separatorBuilder: (context, index) => const SizedBox(width: 10),
              //   itemCount: 5,
              // ),
            ],
          ),
        ),
        // const SizedBox(height: 10),
        // const _LineInfoWidget(),
        Column(
          children: [
            const Text(
              'Ваш баланс',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              '${NumberFormat.simpleCurrency(
                name: '',
                locale: 'ru_RU',
                decimalDigits: 0,
              ).format(int.parse('1212'))}сум',
              style: const TextStyle(fontSize: 25),
            ),
            SizedBox(height: getH(18)),
            1 == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute<dynamic>(
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
                            CupertinoPageRoute<dynamic>(
                              builder: (context) => const PaymentsHistoryView(),
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
                : const Center(child: SizedBox()),
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
                  12.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: getH(60)),
        SizedBox(
          // height: getH(380),
          height: getH(100),
          // height: MediaQuery.of(context).size.height / 3,
          width: double.infinity,
          child: const Placeholder(),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _LineInfoWidget extends StatelessWidget {
  const _LineInfoWidget();

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
  const _ChartCashbackWidget({
    required this.aWeekStatistics,
    required this.maxSum,
  });

  final List<WeeklyStat> aWeekStatistics;
  final double maxSum;

  @override
  State<_ChartCashbackWidget> createState() => _ChartCashbackWidgetState();
}

class _ChartCashbackWidgetState extends State<_ChartCashbackWidget> {
  bool showSum = true;

  bool showCashback = true;

//TODO farqi graphda
  final cashbackDifferenceForGraph = 5;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd-MM-yyyy');

    const color1 = Color.fromRGBO(103, 206, 103, 1);
    const color2 = Color.fromRGBO(255, 144, 62, 1);

    final sumChartBarData = LineChartBarData(
      color: color1,
      isCurved: true,
      curveSmoothness: 0.2,
      barWidth: 3,
      belowBarData: BarAreaData(
        show: true,
        applyCutOffY: true,
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
              ...List.generate(
                widget.aWeekStatistics.length,
                (index) => FlSpot(
                  double.parse(index.toString()),
                  double.parse(
                    widget.aWeekStatistics[index].totalCashback.toString(),
                  ),
                ),
              ),

              // FlSpot(
              //   0,
              //   double.parse(widget.aWeekStatistics[0].cashback.toString()),
              // ),
              // FlSpot(1, 4000),
              // FlSpot(2, 6000),
              // FlSpot(3, 8000),
              // FlSpot(4, 10000),
              // FlSpot(5, 12000),
              // FlSpot(6, 14000),

              // ...widget.aWeekStatistics.map(
              //   (e) {
              //     return FlSpot(
              //       0,
              //       double.parse(e.cashback.toString()),
              //     );
              //   },
              // ),

              // ...widget.aWeekStatistics.map(
              //   (e) {
              //     return FlSpot(
              //       double.parse(
              //         e.date!
              //             .difference(
              //               DateTime.now().subtract(const Duration(days: 7)),
              //             )
              //             .inDays
              //             .abs()
              //             .toString(),
              //       ),
              //       double.parse(e.cashback.toString()),
              //     );
              //   },
              // ),
            ]
          : [FlSpot.zero],
    );

    final cashbackChartBarData = LineChartBarData(
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
        spotsLine: BarAreaSpotsLine(
          checkToShowSpotLine: (spot) {
            return spot.y > 0 ? true : false;
          },
        ),
      ),
      dotData: FlDotData(
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
              // ...widget.aWeekStatistics.map(
              //   (e) => FlSpot(
              //     12.2,
              //     21,
              //   ),
              // ),

              ...List.generate(
                widget.aWeekStatistics.length,
                (index) => FlSpot(
                  double.parse(index.toString()),
                  double.parse(
                        widget.aWeekStatistics[index].cashback.toString(),
                      ) *
                      cashbackDifferenceForGraph,
                ),
              ),

              // ...widget.aWeekStatistics.map(
              //   (e) => FlSpot(
              //     double.parse(
              //       e.date!
              //           .difference(
              //             DateTime.now().subtract(const Duration(days: 7)),
              //           )
              //           .inDays
              //           .abs()
              //           .toString(),
              //     ),
              //     //TODO 5 ga ko'paydi!
              //     double.parse(e.cashback.toString()) * 5,
              //   ),
              // ),
            ]
          : [FlSpot.zero],
    );

    const boxShadow = [
      BoxShadow(
        color: Color.fromRGBO(255, 255, 255, 1),
        blurRadius: 4,
      ),
    ];
    return Column(
      children: [
        // const _LineInfoWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  showSum = !showSum;
                  if (showCashback == false) {
                    showCashback = true;
                    showSum = true;
                  }
                });
              },
              icon: Column(
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
            IconButton(
              onPressed: () {
                setState(() {
                  showCashback = !showCashback;
                  if (showSum == false) {
                    showSum = true;
                    showCashback = true;
                  }
                });
              },
              icon: Column(
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
                      // tooltipBgColor: Colors.grey[900],
                      tooltipBgColor: Colors.grey.shade900,
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
                                  ),
                                )
                              : LineTooltipItem(
                                  NumberFormat.simpleCurrency(
                                    name: '',
                                    locale: 'ru_RU',
                                    decimalDigits: 0,
                                  ).format(
                                    barSpot.y /
                                        cashbackDifferenceForGraph, // bu yerda faqat qiyamti 5 ga bo'linadi, haqiqiysi
                                    // barSpot.y,
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
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Text(
                              value.toInt() > 0
                                  ? '${(value.toInt() / 1000).toStringAsFixed(0)} тыс'
                                  : '',
                              // 'se',
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
                                widget.aWeekStatistics[value.toInt()].date
                                    .toString()
                                    .getLocaleDateWithoutYearWithMont(),
                                // 'as',
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
                  gridData: const FlGridData(
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

class _AddStoreWidget extends StatelessWidget {
  const _AddStoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getH(65),
      width: getH(65),
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: const Color(0x0cffffff),
        ),
        boxShadow: const [
          BoxShadow(
            // color: Color(0x5effffff),
            color: Colors.white,
            blurRadius: 4,
          ),
        ],
        color: Colors.black,
        // gradient: const LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Color(0xff67ce67),
        //     Color(0xffb0fab0),
        //   ],
        // ),
      ),
      child: SvgPicture.asset(
        'assets/svg/broken_add.svg',
        color: Colors.white,
      ),
    );
  }
}
