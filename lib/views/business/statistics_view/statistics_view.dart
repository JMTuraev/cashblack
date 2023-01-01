import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final sumRows = List<DataRow>.generate(
      20,
      (i) => DataRow(
        cells: [
          const DataCell(Center(child: Text('97 333 22 33'))),
          const DataCell(Center(child: Text('1 400 300'))),
          const DataCell(Center(child: Text('20 000'))),
          DataCell(Center(child: Text('Сотрудник Имя Фамилия ${i + 1}'))),
        ],
      ),
    );

    final cashbackRows = List<DataRow>.generate(
      20,
      (i) => const DataRow(
        cells: [
          DataCell(Center(child: Text('97 333 22 33'))),
          DataCell(Center(child: Text('300 000'))),
          DataCell(Center(child: Text('30 200'))),
        ],
      ),
    );

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
              _FilterWidget(
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
                  const DropdownMenuItem<String>(
                    value: '1',
                    child: Text('Сегодня'),
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
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: summa
                        ? _SumWidget(rows: sumRows)
                        : _CashbackWidget(
                            rows: cashbackRows,
                          ),
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
            child: Center(child: Text('Телефон')),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(child: Text('Торговля')),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(child: Text('Кэшбэк')),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(child: Text('Сотрудник')),
          ),
        ),
      ],
      rows: [...rows],
    );
  }
}

class _CashbackWidget extends StatelessWidget {
  const _CashbackWidget({
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
            child: Center(child: Text('Клиент')),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(child: Text('Все')),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(child: Text('Использованные')),
          ),
        ),
      ],
      rows: [...rows],
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
