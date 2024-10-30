import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../size_config.dart';
import '../../../../../string_extensions.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/empty_widget.dart';
import '../../../../../widgets/main_button_widget.dart';
import '../../../../../widgets/search_widget.dart';
import 'prixod_history_view.dart';
import 'rasxod_view.dart';

class RasxpdHistoryListView extends StatefulWidget {
  const RasxpdHistoryListView({
    super.key,
  });

  @override
  State<RasxpdHistoryListView> createState() => _RasxpdHistoryListViewState();
}

class _RasxpdHistoryListViewState extends State<RasxpdHistoryListView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    final prixodList = model.rasxodList.reversed.toList();
    // final skladItems = model.warehousePrixodItems!.data.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('История расходов'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const RasxodView(),
                ),
              );
            },
            icon: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(90),
                ),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: MainButtonWidget(
                      color: Colors.white24,
                      text: 'Фильтр',
                      method: () {},
                      isLoading: false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: SearchWidget(
                      onChanged: (p0) {},
                      onRemoved: () {},
                      controller: TextEditingController(),
                      hintText: 'Искать',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: model.rasxodList.isEmpty
                    ? const Center(child: EmptyWidget())
                    : ListView.separated(
                        itemCount: prixodList.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          var totalPrice = 0.0;
                          for (final element in prixodList[index].rasxodItems) {
                            totalPrice = double.parse(
                              element.priceSellAll.removeWhitespace(),
                            );
                          }
                          return ListTile(
                            // onDoubleTap: () {},
                            minTileHeight: getH(80),
                            tileColor: const Color.fromRGBO(28, 28, 29, 1),
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      // PrixodHistoryView(skladItem: skladItems[index]),
                                      RasxodHistoryView(
                                    skladItem: prixodList[index],
                                  ),
                                ),
                              );
                            },
                            title: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      // 'Серия № ${skladItems[index]}',
                                      'Серия № ${Random().nextInt(100)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      // skladPrixods[index].dateTime.getLocaleDateTime(),
                                      prixodList[index]
                                          .dateTime
                                          .getLocaleDateTime(),
                                      style: const TextStyle(
                                        color: Color(0xff667084),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      // prixodList[index].skladItems.length.toString(),
                                      prixodList[index]
                                              .rasxodItems
                                              .length
                                              .toString() +
                                          (prixodList[index]
                                                      .rasxodItems
                                                      .length ==
                                                  1
                                              ? ' товар'
                                              : ' товаров'),
                                      // skladItems[index].products.length.toString() +
                                      //     (skladItems[index].products.length == 1
                                      //         ? ' товар'
                                      //         : ' товаров'),
                                      style: const TextStyle(
                                        color: Color(0xff34c85a),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      totalPrice.toString().getAmountInSum(),
                                      // prixodList[index].skladItems.length.toString(),
                                      // skladItems[index].total.getFormattedNumber(),
                                      style: const TextStyle(
                                        color: Color(0xff34c85a),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(width: 10),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridWidget extends StatelessWidget {
  const _GridWidget({
    super.key,
    required this.selections,
  });

  final List<String> selections;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: selections.length,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xff262629),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getW(100),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    // 'assets/images/notification/bo-3.png',
                    'assets/images/email.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selections[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      selections[index],
                      style: const TextStyle(
                        color: Color(0xff667084),
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      '0',
                      style: TextStyle(
                        color: Color(0xff34c85a),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
