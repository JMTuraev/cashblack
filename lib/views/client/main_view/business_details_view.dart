import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/client_info.dart';
import '../../../domain/models/client_statistics.dart';
import '../../../domain/models/user_shop.dart';
import '../../../size_config.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';

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

  // String? _filter;

  // onFilterChanged(value) {
  //   setState(() {
  //     _filter = value;
  //   });
  // }

  late Future<ClientStatistics> stats;

  @override
  void initState() {
    stats = context
        .read<ClientHomeViewModel>()
        .getShopStatistics(widget.userShop.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userShop.name),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: EasyRefresh(
            header: const MaterialHeader(),
            onRefresh: () {
              setState(() {
                stats = context
                    .read<ClientHomeViewModel>()
                    .getShopStatistics(widget.userShop.id);
              });
            },
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
                              const Text(
                                'Доступный кэшбек',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                NumberFormat.simpleCurrency(
                                      name: '',
                                      locale: 'ru_RU',
                                      decimalDigits: 0,
                                    ).format(stat.allSeperateCashback) +
                                    'сум',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getH(25)),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'сумма покупки',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(103, 206, 103, 1),
                                      ),
                                    ),
                                    SizedBox(height: getH(6)),
                                    Text(
                                      NumberFormat.simpleCurrency(
                                        name: '',
                                        locale: 'ru_RU',
                                        decimalDigits: 0,
                                      ).format(stat.allSum),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(103, 206, 103, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'все кэшбеки',
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
                                      ).format(stat.allCashback),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(75, 132, 231, 1),
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

                      stat.sort((a, b) => a.date!.compareTo(b.date!));

                      if (stat.length > 0) {
                        final DateFormat formatter =
                            DateFormat('dd MMMM yyyy, EEEE');
                        final DateFormat sorter = DateFormat('dd MMMM yyyy');
                        return Expanded(
                          child: GroupedListView<ClientInfo, String>(
                            elements: stat,
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
                            separator: SizedBox(height: getH(10)),
                            itemBuilder: (context, ClientInfo element) {
                              if (element.isWithdraw) {
                                return _CardOut(sumCashback: element);
                              } else {
                                return _CardIncome(sumCashback: element);
                              }
                            },
                            groupHeaderBuilder: (ClientInfo element) {
                              return Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: getH(14)),
                                child: Text(
                                  formatter
                                      .format(DateTime.parse(element.date!)),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
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
                      // return const LogoAnimatedWidget(size: 1.5);
                      return Expanded(
                        child: Column(
                          children: const [
                            Spacer(),
                            LogoAnimatedWidget(size: 1.5),
                            const SizedBox(height: 20),
                            Spacer(),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardIncome extends StatelessWidget {
  const _CardIncome({
    Key? key,
    required this.sumCashback,
  }) : super(key: key);

  final ClientInfo sumCashback;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat.Hm();

    return Container(
      // margin: EdgeInsets.symmetric(vertical: getW(6)),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Сумма:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: getH(10)),
                    const Text(
                      'Кэшбэк:',
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
                          ).format(sumCashback.price) +
                          'сум',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: getH(10)),
                    Text(
                      NumberFormat.simpleCurrency(
                            name: '',
                            locale: 'ru_RU',
                            decimalDigits: 0,
                          ).format(sumCashback.cashback) +
                          'сум',
                      style: const TextStyle(
                        color: Color(0xff67ce67),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xff34c85a),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Доход',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getH(10)),
                    Text(
                      timeFormatter.format(
                        DateTime.parse(sumCashback.date.toString()),
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
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

class _CardOut extends StatelessWidget {
  const _CardOut({
    Key? key,
    required this.sumCashback,
  }) : super(key: key);

  final ClientInfo sumCashback;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat.Hm();

    return Container(
      // margin: EdgeInsets.symmetric(vertical: getW(6)),
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
                Text(
                  '-' +
                      NumberFormat.simpleCurrency(
                        name: '',
                        locale: 'ru_RU',
                        decimalDigits: 0,
                      ).format(sumCashback.price) +
                      'сум',
                  style: const TextStyle(
                    color: Color(0xffe4002b),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xffe4002b),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Покупка',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getH(10)),
                    Text(
                      timeFormatter.format(
                        DateTime.parse(sumCashback.date.toString()),
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
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
