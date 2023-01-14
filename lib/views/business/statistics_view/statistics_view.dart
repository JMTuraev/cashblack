import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/sum_cashback.dart';
import '../../../domain/models/sum_stat.dart';
import '../../../view_models/statistics_view_model.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  bool summa = true;
  bool cashback = false;

  String? _filter;

  onFilterChanged(value) {
    setState(() {
      _filter = value;
    });
  }

  String start = '2022-01-01';
  String end = '2069-12-12';

  @override
  Widget build(BuildContext context) {
    Future<List<SumStat>> stats =
        context.watch<StatisticsViewModel>().getSumStats();
    // Future<List<SumStat>> stats =
    //     context.watch<StatisticsViewModel>().getSumStats(
    //           start: start,
    //           end: end,
    //         );

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-YYYY');
    final String formatted = formatter.format(now);
    // print('bugun ' + formatted);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: summa
                        ? ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Сумма',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : OutlinedButton(
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
                        ? ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Кэшбэк',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : OutlinedButton(
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
              summa
                  ? _FilterWidget(
                      categoryItems: [
                        const DropdownMenuItem<String>(
                          enabled: false,
                          value: '0',
                          child: Text(
                            'Выберите',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: '1',
                          child: const Text('Сегодня'),
                          onTap: () => stats =
                              context.read<StatisticsViewModel>().getSumStats(
                                    start: formatted,
                                    end: formatted,
                                  ),
                        ),
                        const DropdownMenuItem<String>(
                          value: '2',
                          child: Text('Вчера'),
                        ),
                        const DropdownMenuItem<String>(
                          value: '3',
                          child: Text('Позавчера'),
                        ),
                        const DropdownMenuItem<String>(
                          value: '4',
                          child: Text('Эта неделя'),
                        ),
                        const DropdownMenuItem<String>(
                          value: '5',
                          child: Text('Прошлая неделя'),
                        ),
                        const DropdownMenuItem<String>(
                          value: '6',
                          child: Text('Этот месяц'),
                        ),
                        const DropdownMenuItem<String>(
                          value: '7',
                          child: Text('Прошлый месяц'),
                        ),
                        const DropdownMenuItem<String>(
                          value: '8',
                          child: Text('Последные три месяца'),
                        ),
                        const DropdownMenuItem<String>(
                          value: '9',
                          child: Text('Этот год'),
                        ),
                      ],
                      hint: 'Выберите',
                      onChanged: onFilterChanged,
                      selectedOption: _filter,
                    )
                  : SizedBox(),
              const SizedBox(height: 20),
              Container(
                child: Container(
                  child: Container(
                    // scrollDirection: Axis.horizontal,
                    child: summa
                        ? _SumWidget(
                            stats: stats,
                          )
                        : _CashbackWidget(),
                  ),
                ),
              ),
              // Expanded(
              //   child: _SumWidget(),
              // ),
            ],
          ),
        ),
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
    return FutureBuilder(
      future: stats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<SumStat> sumStat = snapshot.data as List<SumStat>;
          // return Text('data');
          final DateFormat formatter = DateFormat('dd MMMM yyyy, EEEE');
          final DateFormat sorter = DateFormat('dd MMMM yyyy');
          return Expanded(
            child: GroupedListView<SumStat, String>(
              elements: sumStat,
              groupBy: (element) {
                DateTime dates = DateTime.parse(element.date!);
                return DateUtils.dateOnly(dates).toString();

                // return DateTime(dates.year, dates.month, dates.day).toString();
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
              // useStickyGroupSeparators: true,
              // floatingHeader: true,
              order: GroupedListOrder.DESC,
            ),
          );
        } else {
          return const Text('Нет данных');
        }
      },
    );
  }
}

class _CashbackWidget extends StatelessWidget {
  const _CashbackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return FutureBuilder(
      future: context.watch<StatisticsViewModel>().getCashbackStats(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<SumCashback> sumCashback = snapshot.data as List<SumCashback>;
          // return Text('data');

          return Expanded(
            child: ListView.builder(
              itemCount: sumCashback.length,
              itemBuilder: (context, index) => _CardCashback(
                sumCashback: sumCashback[index],
              ),
            ),
          );
        } else {
          return const Text('Нет данных');
        }
      },
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
            isDense: true,
            prefixIcon: Icon(CupertinoIcons.calendar),
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
              horizontal: 6,
            ),
            child: Column(
              children: [
                const SizedBox(height: 6),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_up,
                          color: Colors.green[300],
                        ),
                        Text(
                          sumStat.price.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    // Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.red[300],
                        ),
                        Text(
                          sumStat.cashback.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      Intl.withLocale(
                        'ru_RU',
                        () => timeFormatter
                            .format(DateTime.parse(sumStat.date.toString())),
                      ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      sumStat.fullName.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        sumStat.userName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
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
              horizontal: 6,
            ),
            child: Column(
              children: [
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      sumCashback.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        sumCashback.phone.replaceAllMapped(
                          RegExp(r'(\d{3})(\d{2})(\d{3})(\d{2})(\d+)'),
                          (m) => '+(${m[1]}) ${m[2]} ${m[3]} ${m[4]} ${m[5]}',
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_up,
                          color: Colors.green[300],
                        ),
                        Text(
                          sumCashback.sum.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    // Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.red[300],
                        ),
                        Text(
                          sumCashback.cashback.toStringAsFixed(2),
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
