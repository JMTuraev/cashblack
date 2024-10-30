import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  final double svgSize = 100;

  @override
  Widget build(BuildContext context) {
    final selections = <Map<String, dynamic>>[
      {
        'name': 'Приход',
        'title': 'Создание прихода',
        'background': const Color.fromRGBO(40, 30, 29, 1),
        'page': const PrixodView(),
        'icon': Container(
          padding: const EdgeInsets.all(10),
          // child: Icon(
          //   Icons.add,
          //   size: 100,
          //   color: Color.fromRGBO(222, 93, 71, 1),
          // ),
          child: SvgPicture.asset(
            'assets/svg/warehouse/prixod.svg',
            color: const Color.fromRGBO(222, 93, 71, 1),
            height: svgSize,
            width: svgSize,
          ),
        ),
      },
      {
        'name': 'Расход',
        'title': 'Создание расхода',
        'background': const Color.fromRGBO(23, 36, 53, 1),
        'page': const RasxodView(),
        'icon': Container(
          padding: const EdgeInsets.all(10),
          // child: Icon(
          //   Icons.remove,
          //   size: 100,
          //   color: Color.fromRGBO(91, 142, 199, 1),
          // ),
          child: SvgPicture.asset(
            'assets/svg/warehouse/rasxod.svg',
            color: const Color.fromRGBO(91, 142, 199, 1),
            height: svgSize,
            width: svgSize,
          ),
        ),
      },
      {
        'name': 'История приходов',
        'title': 'Таблицы истории приходов',
        'background': const Color.fromRGBO(45, 37, 24, 1),
        'page': const PrixodHistoryListView(),
        'icon': Container(
          padding: const EdgeInsets.all(10),
          // child: Icon(
          //   Icons.history,
          //   size: 100,
          //   color: Color.fromRGBO(239, 195, 41, 1),
          // ),
          child: SvgPicture.asset(
            'assets/svg/warehouse/historyprixod.svg',
            color: const Color.fromRGBO(239, 195, 41, 1),
            height: svgSize,
            width: svgSize,
          ),
        ),
      },
      {
        'name': 'История расходов',
        'title': 'История расходов (продаж)',
        'background': const Color.fromRGBO(40, 30, 29, 1),
        'page': const RasxpdHistoryListView(),
        'icon': Container(
          padding: const EdgeInsets.all(10),
          // child: Icon(
          //   Icons.history,
          //   size: 100,
          //   color: Color.fromRGBO(222, 93, 71, 1),
          // ),
          child: SvgPicture.asset(
            'assets/svg/warehouse/historyprixod.svg',
            color: const Color.fromRGBO(222, 93, 71, 1),
            height: svgSize,
            width: svgSize,
          ),
        ),
      },
      {
        'name': 'Остаток',
        'title': 'Таблица склада',
        'background': const Color.fromRGBO(53, 30, 38, 1),
        'page': const RemainingItemsListView(),
        'icon': Container(
          padding: const EdgeInsets.all(10),
          // child: Icon(
          //   Icons.store,
          //   size: 100,
          //   color: Color.fromRGBO(220, 82, 131, 1),
          // ),
          child: SvgPicture.asset(
            'assets/svg/warehouse/ostatok.svg',
            color: const Color.fromRGBO(220, 82, 131, 1),
            height: svgSize,
            width: svgSize,
          ),
        ),
      },

      {
        'name': 'Склады',
        'title': 'Приход',
        'background': const Color.fromRGBO(30, 37, 30, 1),
        'page': const WarehouesesListView(),
        'icon': Container(
          padding: const EdgeInsets.all(10),
          // child: Icon(
          //   Icons.store,
          //   size: 100,
          //   color: Color.fromRGBO(71, 163, 78, 1),
          // ),
          child: SvgPicture.asset(
            'assets/svg/service-store.svg',
            color: const Color.fromRGBO(71, 163, 78, 1),
            height: svgSize,
            width: svgSize,
          ),
        ),
      },
      {
        'name': 'Категории',
        'title': 'Категории',
        'background': const Color.fromRGBO(40, 30, 29, 1),
        'page': const WarehoueseCategoriesListView(),
        'icon': Container(
          padding: const EdgeInsets.all(10),
          // child: Icon(
          //   Icons.store,
          //   size: 100,
          //   color: Color.fromRGBO(222, 93, 71, 1),
          // ),
          child: SvgPicture.asset(
            'assets/svg/service-store.svg',
            color: const Color.fromRGBO(222, 93, 71, 1),
            height: svgSize,
            width: svgSize,
          ),
        ),
      },

      {
        'name': 'Поставщики',
        'title': 'Поставщики',
        'background': const Color.fromRGBO(40, 30, 29, 1),
        'page': const WarehoueseProvidersListView(),
        'icon': Container(
          padding: const EdgeInsets.all(10),
          // child: Icon(
          //   Icons.person,
          //   size: 100,
          //   color: Color.fromRGBO(222, 93, 71, 1),
          // ),
          child: SvgPicture.asset(
            'assets/svg/service-store.svg',
            color: const Color.fromRGBO(239, 195, 41, 1),
            height: svgSize,
            width: svgSize,
          ),
        ),
      },
      {
        'name': 'Товары',
        'title': 'Товары',
        'background': const Color.fromRGBO(40, 30, 29, 1),
        'page': const WarehouseItemsListView(),
        'icon': Container(
          padding: const EdgeInsets.all(10),
          // child: Icon(
          //   Icons.store,
          //   size: 100,
          //   color: Color.fromRGBO(222, 93, 71, 1),
          // ),
          child: SvgPicture.asset(
            'assets/svg/service-store.svg',
            color: Colors.white,
            height: svgSize,
            width: svgSize,
          ),
        ),
      },
      // {
      //   'name': 'Инвентаризация',
      //   'page': const RemainingItemsListView(),
      //   'icon': Container(
      // padding: EdgeInsets.all(10),
      //     child: Icon(
      //       Icons.inventory,
      //       size: 100,
      //     ),
      //   ),
      // },
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
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: selections[index]['background'] as Color,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: selections[index]['icon'] as Widget,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selections[index]['name'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            selections[index]['title'].toString(),
                            style: const TextStyle(
                              color: Color(0xff667084),
                              fontSize: 16,
                            ),
                          ),
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
