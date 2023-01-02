import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/screen_wrapper.dart';

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
    return ScreenWrapper(
      child: Column(
        children: [
          // _SwitcherWidget(
          //   isCashback: isCashback,
          //   isGoods: isGoods,
          // ),
          Row(
            children: [
              Expanded(
                child: isCashback
                    ? ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Сумма кэшбэка',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : OutlinedButton(
                        onPressed: () {
                          setState(() {
                            isCashback = true;
                            isGoods = false;
                          });
                        },
                        child: const Text(
                          'Сумма кэшбэка',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: isGoods
                    ? ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Сумма продукции',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : OutlinedButton(
                        onPressed: () {
                          setState(() {
                            isCashback = false;
                            isGoods = true;
                          });
                        },
                        child: const Text(
                          'Сумма продукции',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(height: 20),
          isCashback ? _CashbackWidget() : _GoodsWidget(),
          SizedBox(height: 20),
          // Center(
          //     child: Container(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       await pickRange();
          //       print(dateRange);
          //     },
          //     child: Text('Filter'),
          //   ),
          // )),
          _FilterWidget(
            categoryItems: [
              DropdownMenuItem<String>(
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
                child: Text('Сегодня'),
              ),
              DropdownMenuItem<String>(
                value: '2',
                child: Text('Вчера'),
              ),
              DropdownMenuItem<String>(
                value: '3',
                child: Text('Позавчера'),
              ),
              DropdownMenuItem<String>(
                value: '4',
                child: Text('Эта неделя'),
              ),
              DropdownMenuItem<String>(
                value: '5',
                child: Text('Прошлая неделя'),
              ),
              DropdownMenuItem<String>(
                value: '6',
                child: Text('Этот месяц'),
              ),
              DropdownMenuItem<String>(
                value: '7',
                child: Text('Прошлый месяц'),
              ),
              DropdownMenuItem<String>(
                value: '8',
                child: Text('Последные три месяца'),
              ),
              DropdownMenuItem<String>(
                value: '9',
                child: Text('Этот год'),
              ),
            ],
            hint: 'Выберите',
            onChanged: onFilterChanged,
            selectedOption: _filter,
          ),
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
    return Column(
      children: [
        const Text(
          '0 UZS',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 200,
          width: double.infinity,
          child: _ChartCashbackWidget(),
        ),
      ],
    );
  }
}

class _GoodsWidget extends StatelessWidget {
  const _GoodsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '0 UZS',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 200,
          width: double.infinity,
          child: _ChartGoodsWidget(),
        ),
      ],
    );
  }
}

class _ChartCashbackWidget extends StatelessWidget {
  const _ChartCashbackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
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
                  return Text(
                    value.toInt().toString(),
                    textAlign: TextAlign.center,
                  );
                },
                showTitles: true,
                interval: 1,
                reservedSize: 30,
              ),
            )
            // bottomTitles: AxisTitles(
            //   axisNameSize: 10,
            //   sideTitles: SideTitles(
            //     showTitles: true,
            //   ),
            // ),
            ),
        lineBarsData: [
          LineChartBarData(
            color: Colors.red,
            isCurved: true,
            barWidth: 5,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.red.withOpacity(0.3),
            ),
            spots: [
              // FlSpot(0, 3),
              // FlSpot(1, 3.5),
              // FlSpot(2, 4),
              // FlSpot(3, 2),
              // FlSpot(4, 3),
              // FlSpot(5, 3.4),
              // FlSpot(11, 4),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartGoodsWidget extends StatelessWidget {
  const _ChartGoodsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
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
                  return Text(
                    value.toInt().toString(),
                    textAlign: TextAlign.center,
                  );
                },
                showTitles: true,
                interval: 1,
                reservedSize: 30,
              ),
            )
            // bottomTitles: AxisTitles(
            //   axisNameSize: 10,
            //   sideTitles: SideTitles(
            //     showTitles: true,
            //   ),
            // ),
            ),
        lineBarsData: [
          LineChartBarData(
            color: Colors.blue,
            isCurved: true,
            barWidth: 5,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
            spots: [
              // FlSpot(0, 3),
              // FlSpot(2, 3.1),
              // FlSpot(3, 4),
              // FlSpot(5, 2),
              // FlSpot(7, 3),
              // FlSpot(9, 4),
              // FlSpot(11, 5),
            ],
          ),
        ],
      ),
    );
  }
}

class _SwitcherWidget extends StatelessWidget {
  const _SwitcherWidget({
    Key? key,
    required this.isCashback,
    required this.isGoods,
  }) : super(key: key);

  final bool isCashback;
  final bool isGoods;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: isCashback
              ? ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Sum of cashback',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Sum of cashback',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: isGoods
              ? ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Sum of goods',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Sum of goods',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
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
