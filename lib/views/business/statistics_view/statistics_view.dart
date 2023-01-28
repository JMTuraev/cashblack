import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/sum_cashback.dart';
import '../../../domain/models/sum_stat.dart';
import '../../../extensions.dart';
import '../../../theme/theme_details.dart';
import '../../../view_models/statistics_view_model.dart';
import '../../../widgets/empty_widget.dart';
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

  late Future<List<SumStat>> statsSumFuture;
  late Future<List<SumCashback>> statsCashbackFuture;

  onFilterChanged(value) {
    setState(() {
      _filter = value;
    });
  }

  @override
  void initState() {
    super.initState();
    statsSumFuture =
        context.read<StatisticsViewModel>().getSumStats(start: start, end: end);
    // stats = context.watch<StatisticsViewModel>().sumStats;
    statsCashbackFuture =
        context.read<StatisticsViewModel>().getCashbackStats();
  }

  String start = '2023-01-01';
  String end = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var body = IndexedStack(
      index: summa ? 0 : 1,
      children: [
        _SumWidget(
          stats: statsSumFuture,
        ),
        _CashbackWidget(
          stats: statsCashbackFuture,
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
        bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Фильтр по',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: summa
                        ? OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              'Сумма',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              setState(() {
                                summa = true;
                                cashback = false;
                              });
                            },
                            child: const Text(
                              'Сумма',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: cashback
                        ? OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              'Кэшбэк',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              setState(() {
                                summa = false;
                                cashback = true;
                              });
                            },
                            child: const Text(
                              'Кэшбэк',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                child: summa
                    ? _FilterWidget(
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
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: body,
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
      onTap: () async => context.read<StatisticsViewModel>().getSumStats(
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
              List<SumStat> sumStat = (snapshot.data as List<SumStat>)
                  .where((element) => element.isWithdraw == false)
                  .toList();

              if (sumStat.length > 0) {
                final DateFormat formatter = DateFormat('dd MMMM yyyy, EEEE');
                final DateFormat sorter = DateFormat('dd MMMM yyyy');
                return Expanded(
                  child: GroupedListView<SumStat, String>(
                    elements: sumStat,
                    groupBy: (element) {
                      DateTime dates = DateTime.parse(element.date!);
                      return DateUtils.dateOnly(dates).toString();
                    },
                    groupSeparatorBuilder: (String groupByValue) =>
                        Text(groupByValue),
                    itemBuilder: (context, SumStat element) =>
                        _CardStat(sumStat: element),
                    groupHeaderBuilder: (SumStat element) => Center(
                      child: Text(
                        formatter.format(DateTime.parse(element.date!)),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    order: GroupedListOrder.DESC,
                  ),
                );
              } else {
                return const EmptyWidget();
              }
            } else {
              return Column(
                children: [
                  const LogoAnimatedWidget(
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
                  child: ListView.builder(
                    itemCount: sumCashback.length,
                    itemBuilder: (context, index) => _CardCashback(
                      sumCashback: sumCashback[index],
                    ),
                  ),
                );
              } else {
                return const EmptyWidget();
              }
            } else {
              return Column(
                children: [
                  const LogoAnimatedWidget(
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
            Radius.circular(10),
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
                Radius.circular(10),
              ),
            ),
            isDense: true,
            prefixIcon: Icon(
              CupertinoIcons.calendar,
              color: Colors.white70,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardStat extends StatelessWidget {
  const _CardStat({
    Key? key,
    required this.sumStat,
  }) : super(key: key);

  final SumStat sumStat;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat.Hm();

    return Card(
      color: Colors.white30,
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 1,
          horizontal: 1,
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Column(
              children: [
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(width: 8),
                        const Text(
                          'сумма',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                                name: '',
                                locale: 'ru_RU',
                                decimalDigits: 0,
                              ).format(sumStat.price) +
                              'сум',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        const Text(
                          'кэшбек',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
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
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      timeFormatter
                          .format(DateTime.parse(sumStat.date.toString())),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      sumStat.fullName.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        sumStat.userName.phoneFormatter(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 6),
              ],
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
    required this.sumCashback,
  }) : super(key: key);

  final SumCashback sumCashback;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat('# ##0', 'ru_RU');

    return Card(
      color: Colors.white30,
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 1,
          horizontal: 1,
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Column(
              children: [
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sumCashback.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        sumCashback.phone.phoneFormatter(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'сумма',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                                name: '',
                                locale: 'ru_RU',
                                decimalDigits: 0,
                              ).format(sumCashback.sum) +
                              'сум',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        const Text(
                          'кэшбек',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                            name: '',
                            locale: 'ru_RU',
                            decimalDigits: 0,
                          ).format(sumCashback.cashback),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
