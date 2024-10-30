import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../size_config.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/empty_widget.dart';
import '../../../../../widgets/logo_animated_widget.dart';
import 'create_warehouse_category_view.dart';

class WarehoueseCategoriesListView extends StatefulWidget {
  const WarehoueseCategoriesListView({
    super.key,
  });

  @override
  State<WarehoueseCategoriesListView> createState() =>
      _WarehoueseCategoriesListViewState();
}

class _WarehoueseCategoriesListViewState
    extends State<WarehoueseCategoriesListView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const CreateWarehouseCategoryView(),
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
        child: context.watch<SkladViewModel>().isGettingWarehouseProviders
            ? const LogoAnimatedWidget(size: 1.5)
            : model.warehouseCategories.isEmpty
                ? const Center(child: EmptyWidget())
                : (ListView.separated(
                    itemCount: model.warehouseCategories.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        // onDoubleTap: () {},
                        onTap: () {},
                        minTileHeight: getH(80),
                        tileColor: const Color.fromRGBO(28, 28, 29, 1),
                        // leading: Text('${counter++}'),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'Приход ${counter++}',
                              model.warehouseCategories[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Text(
                            //   // skladPrixods[index].dateTime.getLocaleDateTime(),
                            //   model.warehouseCategories[index].title,
                            //   style: const TextStyle(
                            //     color: Color(0xff667084),
                            //     fontSize: 14,
                            //   ),
                            // ),
                            // Text(
                            //   // skladPrixods[index].model.warehouses.length.toString(),
                            //   model.warehouses[index].shop.name,
                            //   style: const TextStyle(
                            //     color: Color(0xff34c85a),
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                            // const SizedBox(width: 10),
                          ],
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
