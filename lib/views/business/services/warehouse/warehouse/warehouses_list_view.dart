import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/logo_animated_widget.dart';
import 'create_warehouse_view.dart';

class WarehouesesListView extends StatefulWidget {
  const WarehouesesListView({
    super.key,
  });

  @override
  State<WarehouesesListView> createState() => _WarehouesesListViewState();
}

class _WarehouesesListViewState extends State<WarehouesesListView> {
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
        title: const Text('Склады'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const CreateWarehouseView(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: context.watch<SkladViewModel>().isGettingWarehouses
            ? const LogoAnimatedWidget(size: 1.5)
            : ListView.separated(
                itemCount: model.warehouses.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    // onDoubleTap: () {},
                    // onTap: () {
                    //   Navigator.of(context).push(
                    //     CupertinoPageRoute(
                    //       builder: (context) =>
                    //           PrixodHistoryView(skladItem: skladItems[index]),
                    //     ),
                    //   );
                    // },
                    // leading: Text('${counter++}'),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Приход ${counter++}',
                          model.warehouses[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          // skladPrixods[index].dateTime.getLocaleDateTime(),
                          model.warehouses[index].address,
                          style: const TextStyle(
                            color: Color(0xff667084),
                            fontSize: 14,
                          ),
                        ),

                        Text(
                          // skladPrixods[index].model.warehouses.length.toString(),
                          model.warehouses[index].shop.name,
                          style: const TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
              ),
      ),
    );
  }
}
