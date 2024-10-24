import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/sklad/sklad_view_model.dart';
import 'category/warehouse_categories_list_view.dart';
import 'invoice/prixod_history_list_view.dart';
import 'invoice/prixod_view.dart';
import 'item/warehouse_items_list_view.dart';
import 'ostatok/remaining_items_list_view.dart';
import 'provider/warehouse_providers_list_view.dart';
import 'rasxod/rasxod_history_list_view.dart';
import 'rasxod/rasxod_view.dart';
import 'warehouse/warehouses_list_view.dart';

class WarehouseDashboardView extends StatefulWidget {
  const WarehouseDashboardView({
    super.key,
  });

  @override
  State<WarehouseDashboardView> createState() => _WarehouseDashboardViewState();
}

class _WarehouseDashboardViewState extends State<WarehouseDashboardView> {
  @override
  void initState() {
    context.read<SkladViewModel>().getWarehouses();
    context.read<SkladViewModel>().getWarehouseUnits();
    context.read<SkladViewModel>().getWarehouseProviders();
    context.read<SkladViewModel>().getWarehouseCategories();
    context.read<SkladViewModel>().getWarehouseItems();
    context.read<SkladViewModel>().getWarehousePrixodItems();
    context.read<SkladViewModel>().getRemainingItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selections = <Map<String, dynamic>>[
      {
        'name': 'Приход',
        'page': const PrixodView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.add,
            size: 100,
          ),
        ),
      },
      {
        'name': 'Расход',
        'page': const RasxodView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.remove,
            size: 100,
          ),
        ),
      },
      {
        'name': 'Номенклатура',
        'page': const WarehoueseItemsListView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.store,
            size: 100,
          ),
        ),
      },
      {
        'name': 'Склады',
        'page': const WarehouesesListView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.store,
            size: 100,
          ),
        ),
      },
      {
        'name': 'Категории',
        'page': const WarehoueseCategoriesListView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.store,
            size: 100,
          ),
        ),
      },
      {
        'name': 'Поставщики',
        'page': const WarehoueseProvidersListView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.person,
            size: 100,
          ),
        ),
      },
      {
        'name': 'Остаток',
        'page': const RemainingItemsListView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.store,
            size: 100,
          ),
        ),
      },
      {
        'name': 'История приходов',
        'page': const PrixodHistoryListView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.history,
            size: 100,
          ),
        ),
      },
      {
        'name': 'История расходов',
        'page': const RasxpdHistoryListView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.history,
            size: 100,
          ),
        ),
      },
      {
        'name': 'Инвентаризация',
        'page': const RemainingItemsListView(),
        'icon': const FittedBox(
          child: Icon(
            Icons.inventory,
            size: 100,
          ),
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Склад (товары)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _GridWidget(
                selections: selections,
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

  final List<Map<String, dynamic>> selections;

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
        return GestureDetector(
          onDoubleTap: () {},
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => selections[index]['page'] as Widget,
              ),
            );
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff262629),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: getW(100),
                //   width: double.infinity,
                //   child: ClipRRect(
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(15),
                //       topRight: Radius.circular(15),
                //     ),
                //     child: Image.asset(
                //       // 'assets/images/notification/bo-3.png',
                //       'assets/images/email.png',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      (selections[index]['icon'] as Widget),

                      Text(
                        selections[index]['name'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Text(
                      //   selections[index]['name'].toString(),
                      //   style: const TextStyle(
                      //     color: Color(0xff667084),
                      //     fontSize: 14,
                      //   ),
                      // ),
                      // const Text(
                      //   '0',
                      //   style: TextStyle(
                      //     color: Color(0xff34c85a),
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
