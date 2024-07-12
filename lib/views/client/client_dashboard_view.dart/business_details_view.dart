import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/client/client_shop.dart';
import '../../../domain/models/owner/report_cashback.dart';
import '../../../size_config.dart';
import '../../../string_extensions.dart';

class BusinessDetailsView extends StatefulWidget {
  @override
  State<BusinessDetailsView> createState() => _BusinessDetailsViewState();

  final ClientShop userShop;
  const BusinessDetailsView({
    super.key,
    required this.userShop,
  });
}

class _BusinessDetailsViewState extends State<BusinessDetailsView> {
  bool summa = true;

  List<InlineCashbackAndWithdraw> mergedList = [];

  // String? _filter;

  // onFilterChanged(value) {
  //   setState(() {
  //     _filter = value;
  //   });
  // }

  // late Future<ClientStatistics> stats;

  @override
  void initState() {
    // stats = context
    //     .read<ClientHomeViewModel>()
    //     .getShopStatistics(widget.userShop.id);
    mergedList
      ..addAll(widget.userShop.withdraw)
      ..addAll(widget.userShop.cashback);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // stat.sort((a, b) => a.date!.compareTo(b.date!));
    final formatter = DateFormat('dd MMMM yyyy, EEEE');
    final sorter = DateFormat('dd MMMM yyyy');
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
              // setState(() {
              //   stats = context
              //       .read<ClientHomeViewModel>()
              //       .getShopStatistics(widget.userShop.id);
              // });
            },
            child: Column(
              children: [
                Column(
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
                          // NumberFormat.simpleCurrency(
                          //       name: '',
                          //       locale: 'ru_RU',
                          //       decimalDigits: 0,
                          //     ).format('asd') +
                          //     'сум',
                          widget.userShop.amount.toString().getAmountInSum(),
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
                                // 'Сумма покупки',
                                'Выдано',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(255, 144, 62, 1),
                                ),
                              ),
                              SizedBox(height: getH(6)),
                              Text(
                                widget.userShop.withdrawSum
                                    .toString()
                                    .getAmountInSum(),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 144, 62, 1),
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
                                'Все кэшбеки',
                                style: TextStyle(
                                  fontSize: 12,
                                  // color: Color.fromRGBO(75, 132, 231, 1),
                                  color: Color.fromRGBO(103, 206, 103, 1),
                                ),
                              ),
                              SizedBox(height: getH(6)),
                              Text(
                                widget.userShop.cashbackSum
                                    .toString()
                                    .getAmountInSum(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(103, 206, 103, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GroupedListView<InlineCashbackAndWithdraw, String>(
                    elements: mergedList,
                    groupBy: (element) {
                      print(widget.userShop.cashback);
                      final dates = DateTime.parse(element.date);
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
                    itemBuilder: (context, InlineCashbackAndWithdraw element) {
                      if (element.percent == null) {
                        return _CardOut(sumCashback: element);
                      } else {
                        return _CardIncome(sumCashback: element);
                      }
                    },
                    groupHeaderBuilder: (InlineCashbackAndWithdraw element) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: getH(14)),
                        child: Text(
                          formatter.format(DateTime.parse(element.date)),
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
    super.key,
    required this.sumCashback,
  });

  final InlineCashbackAndWithdraw sumCashback;

  @override
  Widget build(BuildContext context) {
    final timeFormatter = DateFormat.Hm();

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
                      sumCashback.totalPrice.toString().getAmountInSum(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: getH(10)),
                    Text(
                      sumCashback.amount.toString().getAmountInSum(),
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
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                        DateTime.parse(sumCashback.date)
                            .add(const Duration(hours: 5)),
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
    super.key,
    required this.sumCashback,
  });

  final InlineCashbackAndWithdraw sumCashback;

  @override
  Widget build(BuildContext context) {
    final timeFormatter = DateFormat.Hm();

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
                const Text(
                  'Сумма:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: getW(10)),
                Text(
                  '-${sumCashback.amount.toString().getAmountInSum()}',
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 144, 62, 1),
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
                        color: const Color.fromRGBO(255, 144, 62, 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Оплата',
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
                        DateTime.parse(sumCashback.date)
                            .add(const Duration(hours: 5)),
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
