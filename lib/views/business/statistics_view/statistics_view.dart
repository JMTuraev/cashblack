// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/sum_cashback.dart';
import '../../../domain/models/sum_stat.dart';
import '../../../extensions.dart';
import '../../../size_config.dart';
import '../../../view_models/statistics_view_model.dart';
import '../../../widgets/active_switcher_widget.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/inactive_switcher_widget.dart';
import '../../../widgets/logo_animated_widget.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  bool summa = true;
  bool cashback = false;

  String? _filter;

  late Future<List<SumStat>> statCashback;
  late Future<List<SumCashback>> statssum;

  onFilterChanged(value) {
    setState(() {
      _filter = value;
    });
  }

  @override
  void initState() {
    super.initState();
    statCashback =
        context.read<StatisticsViewModel>().getSumStats(start: start, end: end);
    // stats = context.watch<StatisticsViewModel>().sumStats;
    statssum = context.read<StatisticsViewModel>().getCashbackStats();
  }

  String start = '2023-01-01';
  String end = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var body = IndexedStack(
      index: summa ? 0 : 1,
      children: [
        _SumWidget(
          stats: statCashback,
        ),
        _CashbackWidget(
          stats: statssum,
        ),
      ],
    );

    final DateTime now = DateTime.now();
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final String today = dateFormatter.format(now);

    String returnDateInString(int days) {
      return dateFormatter.format(
        now.subtract(Duration(days: days)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // const Text(
              //   'Фильтр по',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(28, 28, 29, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: summa
                          ? ActiveSwitcherWidget(
                              onPressed: () {},
                              title: 'Кэшбэк',
                            )
                          : InactiveSwitcherWidget(
                              title: 'Кэшбэк',
                              onPressed: () {
                                setState(() {
                                  summa = true;
                                  cashback = false;
                                });
                              },
                            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: cashback
                          ? ActiveSwitcherWidget(
                              onPressed: () {},
                              title: 'Клиент',
                            )
                          : InactiveSwitcherWidget(
                              onPressed: () {
                                setState(() {
                                  summa = false;
                                  cashback = true;
                                });
                              },
                              title: 'Клиент',
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                child: summa
                    ? Column(
                        children: [
                          _BalanceWidget(
                            cashback: context
                                .watch<StatisticsViewModel>()
                                .cashbackSum,
                            price:
                                context.watch<StatisticsViewModel>().priceSum,
                            withdraw: context
                                .watch<StatisticsViewModel>()
                                .withdrawSum,
                          ),
                          const SizedBox(height: 20),
                          _FilterWidget(
                            categoryItems: [
                              _menuItem(context, 'Выберите', start, end, '0'),
                              _menuItem(context, 'Сегодня', today, today, '1'),
                              _menuItem(
                                context,
                                'Вчера',
                                returnDateInString(1),
                                returnDateInString(1),
                                '2',
                              ),
                              _menuItem(
                                context,
                                'Позавчера',
                                returnDateInString(2),
                                returnDateInString(2),
                                '3',
                              ),
                              _menuItem(
                                context,
                                'Эта неделя',
                                returnDateInString(6),
                                today,
                                '4',
                              ),
                              _menuItem(
                                context,
                                'Прошлая неделя',
                                returnDateInString(13),
                                returnDateInString(7),
                                '5',
                              ),
                              _menuItem(
                                context,
                                'Этот месяц',
                                returnDateInString(30),
                                today,
                                '6',
                              ),
                              _menuItem(
                                context,
                                'Прошлый месяц',
                                returnDateInString(60),
                                returnDateInString(30),
                                '7',
                              ),
                              _menuItem(
                                context,
                                'Этот месяц',
                                returnDateInString(90),
                                today,
                                '8',
                              ),
                              _menuItem(
                                context,
                                'Этот год',
                                dateFormatter.format(
                                  DateTime(DateTime.now().year),
                                ),
                                today,
                                '9',
                              ),
                            ],
                            hint: 'Выберите',
                            onChanged: onFilterChanged,
                            selectedOption: _filter,
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: EasyRefresh(
                  header: const MaterialHeader(),
                  onRefresh: () {
                    setState(() {
                      _filter = '0';

                      String start = '2023-01-01';
                      String end =
                          DateFormat('yyyy-MM-dd').format(DateTime.now());
                      statCashback = context
                          .read<StatisticsViewModel>()
                          .getSumStats(start: start, end: end);

                      statssum = context
                          .read<StatisticsViewModel>()
                          .getCashbackStats();
                    });
                  },
                  child: body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> _menuItem(
    BuildContext context,
    String title,
    String today,
    String end,
    String value,
  ) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: value == '0' ? FontWeight.bold : null,
        ),
      ),
      onTap: () async =>
          statCashback = context.read<StatisticsViewModel>().getSumStats(
                start: today,
                end: end,
              ),
    );
  }
}

class _SumWidget extends StatelessWidget {
  const _SumWidget({
    Key? key,
    required this.stats,
  }) : super(key: key);

  final Future<List<SumStat>> stats;

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return Column(
      children: [
        FutureBuilder(
          future: stats,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<SumStat> sumStat = (snapshot.data as List<SumStat>);
              // sumStat.sort((a, b) =>
              //     DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)));
              sumStat.sort((a, b) => a.date!.compareTo(b.date!));

              if (sumStat.length > 0) {
                final DateFormat formatter = DateFormat('dd MMMM yyyy, EEEE');
                // final DateFormat sorter = DateFormat('dd MMMM yyyy');
                return Expanded(
                  child: GroupedListView<SumStat, String>(
                    elements: sumStat,
                    groupBy: (element) {
                      DateTime dates = DateTime.parse(element.date!);
                      return DateUtils.dateOnly(dates).toString();
                      // return DateTime(dates.year, dates.month, dates.day,
                      //         dates.hour, dates.minute)
                      //     .toString();
                    },
                    groupSeparatorBuilder: (String groupByValue) {
                      print(groupByValue);
                      return Text(groupByValue);
                    },
                    // groupSeparatorBuilder: (String groupByValue) {
                    //   print(groupByValue);
                    //   DateTime dates = DateTime.parse(groupByValue);
                    //   return Text(DateUtils.dateOnly(dates).toString());
                    //   // return Text(
                    //   //     formatter.format(DateTime.parse(groupByValue)));
                    // },
                    itemBuilder: (context, SumStat element) {
                      if (!element.isWithdraw) {
                        return _CardCashback(sumStat: element);
                      } else {
                        return _CardWithdraw(sumStat: element);
                      }
                    },
                    separator: SizedBox(height: getH(10)),
                    groupHeaderBuilder: (SumStat element) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: getH(14)),
                        child: Text(
                          formatter.format(DateTime.parse(element.date!)),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    // groupHeaderBuilder: (SumStat element) => Center(
                    //   child: Text(
                    //     formatter.format(DateTime.parse(element.date!)),
                    //     style: const TextStyle(
                    //       fontSize: 20,
                    //     ),
                    //   ),
                    // ),
                    order: GroupedListOrder.DESC,
                    groupComparator: (value1, value2) {
                      // print(value1);
                      return value1.compareTo(value2);
                    },
                  ),
                );
              } else {
                return const Center(child: EmptyWidget());
              }
            } else {
              return Column(
                children: const [
                  LogoAnimatedWidget(
                    size: 1.5,
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

class _CashbackWidget extends StatelessWidget {
  const _CashbackWidget({
    Key? key,
    required this.stats,
  }) : super(key: key);

  final Future<List<SumCashback>> stats;

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return Column(
      children: [
        FutureBuilder(
          future: stats,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<SumCashback> sumCashback =
                  snapshot.data as List<SumCashback>;
              if (sumCashback.length > 0) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: sumCashback.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: getH(10)),
                    itemBuilder: (context, index) => _CardClient(
                      sumCashback: sumCashback[index],
                    ),
                  ),
                );
              } else {
                return const Center(child: EmptyWidget());
              }
            } else {
              return Column(
                children: const [
                  LogoAnimatedWidget(
                    size: 1.5,
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

class _FilterWidget extends StatelessWidget {
  const _FilterWidget({
    Key? key,
    required String? selectedOption,
    required this.categoryItems,
    required this.onChanged,
    required this.hint,
  })  : _selectedOption = selectedOption,
        super(key: key);

  final String? _selectedOption;
  final List<DropdownMenuItem<String>> categoryItems;
  final Function onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: DropdownButtonFormField<String>(
          style: const TextStyle(
            fontSize: 16,
          ),
          hint: Text(hint),
          isExpanded: true,
          value: _selectedOption,
          items: categoryItems,
          onChanged: (value) => onChanged(value),
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            isDense: true,
            prefixIcon: Icon(
              CupertinoIcons.calendar,
              color: Colors.white70,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardCashback extends StatelessWidget {
  const _CardCashback({
    Key? key,
    required this.sumStat,
  }) : super(key: key);

  final SumStat sumStat;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat.Hm();

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color.fromRGBO(28, 28, 29, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    sumStat.fullName!.length > 2
                        ? sumStat.fullName.toString()
                        : sumStat.userName.phoneHiddenFormatter(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: getW(4)),
                const _ChipWidget(
                  title: 'Продажа',
                  color: Color(0xff34c85a),
                ),
                SizedBox(width: getW(12)),
                Text(
                  timeFormatter.format(DateTime.parse(sumStat.date.toString())),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: getH(6)),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Сумма:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Кэшбэк:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: getW(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      NumberFormat.simpleCurrency(
                            name: '',
                            locale: 'ru_RU',
                            decimalDigits: 0,
                          ).format(sumStat.price) +
                          'сум',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(
                            name: '',
                            locale: 'ru_RU',
                            decimalDigits: 0,
                          ).format(sumStat.cashback) +
                          'сум',
                      style: const TextStyle(
                        color: Color(0xff67ce67),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CardClient extends StatelessWidget {
  const _CardClient({
    Key? key,
    required this.sumCashback,
  }) : super(key: key);

  final SumCashback sumCashback;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat.Hm();

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color.fromRGBO(28, 28, 29, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    sumCashback.name.length > 2
                        ? sumCashback.name
                        : sumCashback.phone.phoneHiddenFormatter(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getH(6)),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Сумма:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Кэшбэк:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: getW(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      NumberFormat.simpleCurrency(
                            name: '',
                            locale: 'ru_RU',
                            decimalDigits: 0,
                          ).format(sumCashback.sum) +
                          'сум',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(
                            name: '',
                            locale: 'ru_RU',
                            decimalDigits: 0,
                          ).format(sumCashback.cashback) +
                          'сум',
                      style: const TextStyle(
                        color: Color(0xff67ce67),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // return Card(
    //   color: Colors.white30,
    //   child: Card(
    //     margin: const EdgeInsets.symmetric(
    //       vertical: 1,
    //       horizontal: 1,
    //     ),
    //     child: Container(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(
    //           vertical: 10,
    //           horizontal: 10,
    //         ),
    //         child: Column(
    //           children: [
    //             const SizedBox(height: 6),
    //             Row(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   sumCashback.name,
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     color: Colors.grey[200],
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //                 const SizedBox(width: 16),
    //                 Expanded(
    //                   child: Text(
    //                     sumCashback.phone.phoneFormatter(),
    //                     style: TextStyle(
    //                       fontSize: 14,
    //                       color: Colors.grey[200],
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     overflow: TextOverflow.ellipsis,
    //                   ),
    //                 ),
    //                 const SizedBox(width: 8),
    //               ],
    //             ),
    //             const SizedBox(height: 6),
    //             Row(
    //               children: [
    //                 Column(
    //                   children: [
    //                     const Text(
    //                       'сумма',
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.grey,
    //                       ),
    //                     ),
    //                     Text(
    //                       NumberFormat.simpleCurrency(
    //                             name: '',
    //                             locale: 'ru_RU',
    //                             decimalDigits: 0,
    //                           ).format(sumCashback.sum) +
    //                           'сум',
    //                       style: const TextStyle(
    //                         fontSize: 18,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(width: 20),
    //                 Column(
    //                   children: [
    //                     const Text(
    //                       'кэшбек',
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.grey,
    //                       ),
    //                     ),
    //                     Text(
    //                       NumberFormat.simpleCurrency(
    //                         name: '',
    //                         locale: 'ru_RU',
    //                         decimalDigits: 0,
    //                       ).format(sumCashback.cashback),
    //                       style: const TextStyle(
    //                         fontSize: 18,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 6),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _CardWithdraw extends StatelessWidget {
  const _CardWithdraw({
    Key? key,
    required this.sumStat,
  }) : super(key: key);

  final SumStat sumStat;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat.Hm();

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color.fromRGBO(28, 28, 29, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    sumStat.fullName!.length > 2
                        ? sumStat.fullName.toString()
                        : sumStat.userName.phoneHiddenFormatter(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: getW(4)),
                const _ChipWidget(
                  title: 'Оплачено',
                  color: Color.fromRGBO(255, 144, 62, 1),
                ),
                SizedBox(width: getW(12)),
                Text(
                  timeFormatter.format(DateTime.parse(sumStat.date.toString())),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: getH(10)),
            Text(
              '-' +
                  NumberFormat.simpleCurrency(
                    name: '',
                    locale: 'ru_RU',
                    decimalDigits: 0,
                  ).format(sumStat.price) +
                  'сум',
              style: const TextStyle(
                color: Color.fromRGBO(255, 144, 62, 1),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
    // return Card(
    //   color: Colors.red[300],
    //   child: Card(
    //     margin: const EdgeInsets.symmetric(
    //       vertical: 1,
    //       horizontal: 1,
    //     ),
    //     child: Container(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(
    //           vertical: 10,
    //           horizontal: 10,
    //         ),
    //         child: Column(
    //           children: [
    //             const SizedBox(height: 6),
    //             Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 Column(
    //                   children: [
    //                     const SizedBox(width: 8),
    //                     const Text(
    //                       'Оплачено',
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.grey,
    //                       ),
    //                     ),
    //                     Text(
    //                       NumberFormat.simpleCurrency(
    //                             name: '',
    //                             locale: 'ru_RU',
    //                             decimalDigits: 0,
    //                           ).format(sumStat.price) +
    //                           'сум',
    //                       style: const TextStyle(
    //                         fontSize: 18,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(width: 20),
    //                 const Spacer(),
    //                 Text(
    //                   timeFormatter
    //                       .format(DateTime.parse(sumStat.date.toString())),
    //                   style: TextStyle(
    //                     fontSize: 12,
    //                     color: Colors.grey[400],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 6),
    //             Row(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   sumStat.fullName.toString(),
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     color: Colors.grey[200],
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //                 const SizedBox(width: 16),
    //                 Expanded(
    //                   child: Text(
    //                     sumStat.userName.phoneFormatter(),
    //                     style: TextStyle(
    //                       fontSize: 14,
    //                       color: Colors.grey[200],
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     overflow: TextOverflow.ellipsis,
    //                   ),
    //                 ),
    //                 const SizedBox(width: 8),
    //               ],
    //             ),
    //             const SizedBox(height: 6),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _ChipWidget extends StatelessWidget {
  const _ChipWidget({
    super.key,
    required this.title,
    required this.color,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 2,
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({
    Key? key,
    required this.price,
    required this.withdraw,
    required this.cashback,
  }) : super(key: key);

  final int price;
  final int withdraw;
  final double cashback;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Продажа',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff34c85a),
                  ),
                ),
                SizedBox(height: getH(6)),
                Text(
                  NumberFormat.simpleCurrency(
                    name: '',
                    locale: 'ru_RU',
                    decimalDigits: 0,
                  ).format(price),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Color(0xff34c85a),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'сум',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff34c85a),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Кэшбек',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(75, 132, 231, 1),
                  ),
                ),
                SizedBox(height: getH(6)),
                Text(
                  NumberFormat.simpleCurrency(
                    name: '',
                    locale: 'ru_RU',
                    decimalDigits: 0,
                  ).format(cashback),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(75, 132, 231, 1),
                  ),
                ),
                const Text(
                  'сум',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(75, 132, 231, 1),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Оплачено',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(255, 144, 62, 1),
                  ),
                ),
                SizedBox(height: getH(6)),
                Text(
                  NumberFormat.simpleCurrency(
                    name: '',
                    locale: 'ru_RU',
                    decimalDigits: 0,
                  ).format(withdraw),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 144, 62, 1),
                  ),
                ),
                const Text(
                  'сум',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(255, 144, 62, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
