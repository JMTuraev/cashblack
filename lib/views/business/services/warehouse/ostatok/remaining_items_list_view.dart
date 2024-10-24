import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../string_extensions.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/logo_animated_widget.dart';

class RemainingItemsListView extends StatefulWidget {
  const RemainingItemsListView({
    super.key,
  });

  @override
  State<RemainingItemsListView> createState() => _RemainingItemsListViewState();
}

class _RemainingItemsListViewState extends State<RemainingItemsListView> {
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
        title: const Text('Остаток'),
        actions: const [
          // IconButton(
          //   onPressed: () {
          //   },
          //   icon: const Icon(Icons.add),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: context.watch<SkladViewModel>().isGettingWarehouseRemainings
            ? const LogoAnimatedWidget(size: 1.5)
            : ListView.separated(
                itemCount: model.skladRemainings.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    // onDoubleTap: () {},
                    onTap: () {},
                    // leading: Text('${counter++}'),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Приход ${counter++}',
                          model.skladRemainings[index].warehouseItem.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              // skladPrixods[index].model.warehouses.length.toString(),
                              'Остаток ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              // skladPrixods[index].model.warehouses.length.toString(),
                              model.skladRemainings[index].quantity
                                  .toString()
                                  .getFormattedNumber(),
                              style: const TextStyle(
                                color: Color(0xff34c85a),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              // skladPrixods[index].model.warehouses.length.toString(),
                              'Аттрибут ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              // skladPrixods[index].model.warehouses.length.toString(),
                              model.skladRemainings[index].warehouseItem.unit
                                  .name,
                              style: const TextStyle(
                                color: Color(0xff34c85a),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              // skladPrixods[index].model.warehouses.length.toString(),
                              'Категория ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              // skladPrixods[index].model.warehouses.length.toString(),
                              model.warehouseItems[index].category.name,
                              style: const TextStyle(
                                color: Color(0xff34c85a),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
