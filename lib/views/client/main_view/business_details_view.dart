import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/client_info.dart';
import '../../../domain/models/client_statistics.dart';
import '../../../domain/models/user_shop.dart';
import '../../../theme/theme_details.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/medium_title_widget.dart';

class BusinessDetailsView extends StatefulWidget {
  @override
  State<BusinessDetailsView> createState() => _BusinessDetailsViewState();

  final UserShop userShop;
  const BusinessDetailsView({
    Key? key,
    required this.userShop,
  }) : super(key: key);
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
    Future<ClientStatistics> stats = context
        .watch<ClientHomeViewModel>()
        .getShopStatistics(widget.userShop.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userShop.name),
        bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              FutureBuilder(
                future: stats,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var stat = snapshot.data as ClientStatistics;
                    return Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              NumberFormat.simpleCurrency(
                                    name: '',
                                    locale: 'ru_RU',
                                    decimalDigits: 0,
                                  ).format(stat.allSeperateCashback) +
                                  'сум',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'кэшбек',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    NumberFormat.simpleCurrency(
                                      name: '',
                                      locale: 'ru_RU',
                                      decimalDigits: 0,
                                    ).format(stat.allSum),
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'сумма покупки',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(width: 10),
                            const Icon(Icons.circle, size: 6),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    NumberFormat.simpleCurrency(
                                      name: '',
                                      locale: 'ru_RU',
                                      decimalDigits: 0,
                                    ).format(stat.allCashback),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'все кэшбеки',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else
                    return const Text(
                      '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                },
              ),

              const SizedBox(height: 20),
              FutureBuilder(
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
                        // padding: EdgeInsets.only(top: 6),
                        groupBy: (element) {
                          DateTime dates = DateTime.parse(element.date);
                          return DateUtils.dateOnly(dates).toString();

                          // return DateTime(dates.year, dates.month, dates.day).toString();
                        },
                        groupSeparatorBuilder: (String groupByValue) =>
                            Text(groupByValue),
                        itemBuilder: (context, ClientInfo element) {
                          if (element.isWithdraw) {
                            return _CardWithdraw(sumStat: element);
                          } else {
                            return _CardCashback(sumStat: element);
                          }
                        },
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

class _CardCashback extends StatelessWidget {
  const _CardCashback({
    Key? key,
    required this.sumStat,
  }) : super(key: key);

  final ClientInfo sumStat;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat.Hm();

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Card(
        color: Colors.green[300],
        child: Card(
          margin: const EdgeInsets.symmetric(
            vertical: 1,
            horizontal: 1,
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
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
                            ).format(sumStat.price) +
                            'UZS',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    // mainAxisAlignment: MainAxisAlignment.center,
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
                            'UZS',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    timeFormatter.format(
                      DateTime.parse(sumStat.date.toString()),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardWithdraw extends StatelessWidget {
  const _CardWithdraw({
    Key? key,
    required this.sumStat,
  }) : super(key: key);

  final ClientInfo sumStat;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat.Hm();

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Card(
        color: Colors.red[300],
        child: Card(
          margin: const EdgeInsets.symmetric(
            vertical: 1,
            horizontal: 1,
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'покупка',
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
                            'UZS',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'имя сотрудника',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          sumStat.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    timeFormatter.format(
                      DateTime.parse(sumStat.date.toString()),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
