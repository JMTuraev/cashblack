import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/one_month_statistic.dart';
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
      edge: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          _CashbackWidget(),
          SizedBox(height: 20),
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
          height: MediaQuery.of(context).size.height / 3.5,
          width: double.infinity,
          child: FutureBuilder(
            future: context.watch<BusinessHomeViewModel>().getStatistics(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<OneMonthStatistic> stats =
                    snapshot.data as List<OneMonthStatistic>;
                print('++++' + stats.toList().toString());

                if (stats.isNotEmpty) {
                  return _ChartCashbackWidget(
                    stats: stats,
                  );
                } else
                  return _EmptyChartCashbackWidget();
              } else
                return _EmptyChartCashbackWidget();
            },
          ),
        ),
      ],
    );
  }
}

class _EmptyChartCashbackWidget extends StatelessWidget {
  const _EmptyChartCashbackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 30,
        minY: 0,
        maxY: 0,
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
                  return Center(
                    child: Text(
                      (value.toInt() / 1000).toString(),
                      // '1',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                showTitles: true,
                interval: 2,
                reservedSize: 30,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value.toInt().toString(),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                showTitles: true,
                interval: 5,
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
            color: Colors.blue,
            isCurved: true,
            barWidth: 5,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
            spots: [],
          ),
          LineChartBarData(
            color: Colors.red,
            isCurved: true,
            barWidth: 5,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.red.withOpacity(0.3),
            ),
            spots: [],
          ),
        ],
      ),
    );
  }
}

class _ChartCashbackWidget extends StatelessWidget {
  const _ChartCashbackWidget({
    Key? key,
    required this.stats,
  }) : super(key: key);

  final List<OneMonthStatistic> stats;

  @override
  Widget build(BuildContext context) {
    double maxSum = 0;
    stats.forEach(
      (e) {
        print('sana' + e.date.toString());
        var dif = e.date?.difference(DateTime.now());
        print(dif?.inDays.toString());
        if (double.parse(e.price.toString()) > maxSum) {
          maxSum = double.parse(e.price.toString());
          print('maxsum' + maxSum.toString());
        }
      },
    );

    return LineChart(
      LineChartData(
        minX: 0,
        // maxX: 30,
        maxX: double.parse(stats.length.toString()) - 1,
        minY: 0,
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
                  return Center(
                    child: Text(
                      (value.toInt() / 1000).toString(),
                      // '1',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                showTitles: true,
                interval: maxSum != 0 ? (maxSum / 3) : 1,
                reservedSize: 30,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value.toInt().toString(),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                showTitles: true,
                interval: 5,
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
            color: Colors.blue,
            isCurved: true,
            barWidth: 5,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
            spots: [
              // FlSpot(0, 3),
              // FlSpot(30, 4),

              ...stats.map(
                (e) => FlSpot(
                    double.parse(e.date!
                        .difference(DateTime.now())
                        .inDays
                        .abs()
                        .toString()),
                    double.parse(e.price.toString())),
              ),
            ],
          ),
          LineChartBarData(
            color: Colors.red,
            isCurved: true,
            barWidth: 5,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.red.withOpacity(0.3),
            ),
            spots: [
              ...stats.map(
                (e) => FlSpot(
                    double.parse(e.date!
                        .difference(DateTime.now())
                        .inDays
                        .abs()
                        .toString()),
                    double.parse(e.cashback.toString())),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class _ChartGoodsWidget extends StatelessWidget {
//   const _ChartGoodsWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         minX: 0,
//         maxX: 11,
//         minY: 0,
//         maxY: 6,
//         titlesData: FlTitlesData(
//             show: true,
//             rightTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//             topTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 getTitlesWidget: (value, meta) {
//                   return Text(
//                     value.toInt().toString(),
//                     textAlign: TextAlign.center,
//                   );
//                 },
//                 showTitles: true,
//                 interval: 1,
//                 reservedSize: 30,
//               ),
//             )
//             // bottomTitles: AxisTitles(
//             //   axisNameSize: 10,
//             //   sideTitles: SideTitles(
//             //     showTitles: true,
//             //   ),
//             // ),
//             ),
//         lineBarsData: [
//           LineChartBarData(
//             color: Colors.blue,
//             isCurved: true,
//             barWidth: 5,
//             belowBarData: BarAreaData(
//               show: true,
//               color: Colors.blue.withOpacity(0.3),
//             ),
//             spots: [
//               // FlSpot(0, 3),
//               // FlSpot(2, 3.1),
//               // FlSpot(3, 4),
//               // FlSpot(5, 2),
//               // FlSpot(7, 3),
//               // FlSpot(9, 4),
//               // FlSpot(11, 5),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SwitcherWidget extends StatelessWidget {
//   const _SwitcherWidget({
//     Key? key,
//     required this.isCashback,
//     required this.isGoods,
//   }) : super(key: key);

//   final bool isCashback;
//   final bool isGoods;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: isCashback
//               ? ElevatedButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Sum of cashback',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               : OutlinedButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Sum of cashback',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: isGoods
//               ? ElevatedButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Sum of goods',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               : OutlinedButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Sum of goods',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//         ),
//       ],
//     );
//   }
// }

// class _FilterWidget extends StatelessWidget {
//   const _FilterWidget({
//     Key? key,
//     required String? selectedOption,
//     required this.categoryItems,
//     required this.onChanged,
//     required this.hint,
//   })  : _selectedOption = selectedOption,
//         super(key: key);

//   final String? _selectedOption;
//   final List<DropdownMenuItem<String>> categoryItems;
//   final Function onChanged;
//   final String hint;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Container(
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ),
//         ),
//         child: DropdownButtonFormField<String>(
//           style: const TextStyle(
//             fontSize: 16,
//           ),
//           hint: Text(hint),
//           isExpanded: true,
//           value: _selectedOption,
//           items: categoryItems,
//           onChanged: (value) => onChanged(value),
//           decoration: const InputDecoration(
//             isDense: true,
//             prefixIcon: Icon(CupertinoIcons.calendar),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
