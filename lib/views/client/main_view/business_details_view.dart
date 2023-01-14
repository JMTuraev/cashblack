import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/client_info.dart';
import '../../../domain/models/client_statistics.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/medium_title_widget.dart';

class BusinessDetailsView extends StatefulWidget {
  BusinessDetailsView({super.key, required this.id, required this.name});

  @override
  State<BusinessDetailsView> createState() => _BusinessDetailsViewState();

  final int id;
  final String name;
}

class _BusinessDetailsViewState extends State<BusinessDetailsView> {
  bool summa = true;

  String? _filter;

  onFilterChanged(value) {
    setState(() {
      _filter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<ClientStatistics> stats =
        context.watch<ClientHomeViewModel>().getShopStatistics(widget.id);

    final sumRows = List<DataRow>.generate(
      20,
      (i) => const DataRow(
        cells: [
          DataCell(Center(child: Text('500 300'))),
          DataCell(Center(child: Text('3.5 %'))),
          DataCell(Center(child: Text('20 000'))),
          DataCell(Center(child: Text('12.12.2022 23:22'))),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MediumTitleWidget(text: widget.name),
              const SizedBox(height: 20),
              FutureBuilder(
                future: stats,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var stat = snapshot.data as ClientStatistics;
                    return Row(
                      children: [
                        Spacer(),
                        Text(
                          stat.allSum.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.circle, size: 6),
                        SizedBox(width: 10),
                        Text(
                          stat.allCashback.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                      ],
                    );
                  } else
                    return Text(
                      '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                },
              ),

              const SizedBox(height: 20),
              _FilterWidget(
                categoryItems: const [
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
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: stats,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var stat = snapshot.data!.clientInfo as List<ClientInfo>;

                      // return Text('data');
                      final DateFormat formatter =
                          DateFormat('dd MMMM yyyy, EEEE');
                      final DateFormat sorter = DateFormat('dd MMMM yyyy');
                      return Expanded(
                        child: GroupedListView<ClientInfo, String>(
                          elements: stat,
                          groupBy: (element) {
                            DateTime dates = DateTime.parse(element.date);
                            return DateUtils.dateOnly(dates).toString();

                            // return DateTime(dates.year, dates.month, dates.day).toString();
                          },
                          groupSeparatorBuilder: (String groupByValue) =>
                              Text(groupByValue),
                          itemBuilder: (context, ClientInfo element) =>
                              _CardStat(sumStat: element),
                          groupHeaderBuilder: (ClientInfo element) => Center(
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
                ),
                // child: ListView.builder(
                //   itemCount: 2,
                //   itemBuilder: (context, index) {
                //     return Column(
                //       children: [
                //         _CardGeneric(color: Colors.red.shade200),
                //         _CardGeneric(color: Colors.green.shade200),
                //         _CardGeneric(color: Colors.red.shade200),
                //       ],
                //     );
                //   },
                // ),
              ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: _SumWidget(rows: sumRows),
              //     ),
              //   ),
              // ),
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

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '3 января 2023, понедельник',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Column(
              children: [
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Buxoro markaziy bozori 12-do`kon ikkinchi bo`lim',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  // mainAxisAlignment:
                  //     MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_up,
                          color: Colors.green[300],
                        ),
                        Text(
                          '200 000',
                          style: TextStyle(
                            fontSize: 16,
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
                          '2 100',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CardGeneric extends StatelessWidget {
  const _CardGeneric({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '3 января 2023, понедельник',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Card(
          color: color,
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
                    SizedBox(height: 6),
                    Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_drop_up,
                              color: Colors.green[300],
                            ),
                            Text(
                              '200 000 000 UZS',
                              style: TextStyle(
                                fontSize: 16,
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
                              '2 100 000 UZS',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          '22:22',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Buxoro markaziy bozori 12-do`kon ikkinchi bo`lim',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
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

class _CardRed extends StatelessWidget {
  const _CardRed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '3 января 2023, понедельник',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Card(
          color: Colors.red[200],
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
                    SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Buxoro markaziy bozori 12-do`kon ikkinchi bo`lim',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_drop_up,
                              color: Colors.green[300],
                            ),
                            Text(
                              '200 000',
                              style: TextStyle(
                                fontSize: 16,
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
                              '2 100',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
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

class _SumWidget extends StatelessWidget {
  const _SumWidget({
    Key? key,
    required this.rows,
  }) : super(key: key);

  final List<DataRow> rows;

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    return DataTable(
      horizontalMargin: 20,
      columnSpacing: 20,
      headingTextStyle: textStyle,
      border: TableBorder.all(
        width: 1,
        color: Colors.white70,
      ),
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Center(child: Text('Savdo')),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(child: Text('Cashback %')),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(child: Text('Cashback')),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(child: Text('Sana')),
          ),
        ),
      ],
      rows: [
        ...rows,
        DataRow(
          cells: [
            DataCell(Center(child: Text('1 400 300', style: textStyle))),
            DataCell(Center(child: Text('3.5 %', style: textStyle))),
            DataCell(Center(child: Text('20 000', style: textStyle))),
            DataCell(Center(child: Text('12.12.2022 23:22', style: textStyle))),
          ],
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

class _CardStat extends StatelessWidget {
  const _CardStat({
    Key? key,
    required this.sumStat,
  }) : super(key: key);

  final ClientInfo sumStat;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat.Hm();

    return Card(
      color: Colors.green[300],
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
                        sumStat.fullName,
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

  final ClientInfo sumCashback;

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
                      sumCashback.fullName,
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
                        sumCashback.fullName,
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
                          sumCashback.fullName,
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
