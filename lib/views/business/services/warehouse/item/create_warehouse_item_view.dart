import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../size_config.dart';
import '../../../../../view_models/business/business_dashboard_view_model.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/add_widget.dart';
import '../../../../../widgets/main_button_widget.dart';
import '../../../../../widgets/show_modal.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../../scanner_view/payment_phone_view.dart';
import '../category/create_warehouse_category_view.dart';

class CreateWarehouseItemView extends StatefulWidget {
  const CreateWarehouseItemView({super.key});

  @override
  State<CreateWarehouseItemView> createState() =>
      _CreateWarehouseItemViewState();
}

class _CreateWarehouseItemViewState extends State<CreateWarehouseItemView> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<SkladViewModel>().randomBarcode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    final modelUser = context.read<BusinessDashboardViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Новый товар'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topCenter,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFieldWidget(
                  hintText: 'Наименование',
                  showLabel: true,
                  controller: model.warehouseItemNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SelectCategoryWidget(
                  validator: (value) {
                    if (value == null || value == '0') {
                      return 'Выберите поле';
                    }
                    return null;
                  },
                  selectedOption: model.selectedWarehouseItemUnitId,
                  categoryItems: [
                    const DropdownMenuItem(
                      value: '0',
                      enabled: false,
                      child: Text('Выберите аттрибут'),
                    ),
                    ...model.warehouseUnits.map(
                      (e) => DropdownMenuItem(
                        value: e.id.toString(),
                        child: Text(e.title),
                      ),
                    ),
                  ],
                  onChanged: (String value) {
                    model.selectedWarehouseItemUnitId = value;
                  },
                  hint: 'Аттрибут',
                ),
                const SizedBox(height: 10),
                SelectCategoryWidget(
                  validator: (value) {
                    if (value == null || value == '0') {
                      return 'Выберите поле';
                    }
                    return null;
                  },
                  selectedOption: model.selectedWarehouseItemCategoryId,
                  categoryItems: [
                    DropdownMenuItem(
                      value: '0',
                      enabled: false,
                      child: Row(
                        children: [
                          const Text('Выберите категорию'),
                          const Spacer(),
                          AddWidget(
                            onPressed: () {
                              // Navigator.pop(
                              //   dropdownState.currentContext!,
                              // ); // Close the dropdown list
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const CreateWarehouseCategoryView(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    ...model.warehouseCategories.map(
                      (e) => DropdownMenuItem(
                        value: e.id.toString(),
                        child: Text(e.name),
                      ),
                    ),
                  ],
                  onChanged: (String value) {
                    model.selectedWarehouseItemCategoryId = value;
                  },
                  hint: 'Категория',
                ),
                const SizedBox(height: 10),
                // TextFieldWidget(
                //   hintText: 'Порог оповещения о количестве',
                //   showLabel: true,
                //   controller: model.warehouseItemLowerController,
                //   textType: TextInputType.number,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Заполните поле';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 10),
                TextFieldWidget(
                  hintText: 'Теги (vergul bilan ajratiladi)',
                  showLabel: true,
                  controller: model.warehouseItemTagsController,
                  // textType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  hintText: 'Barcode',
                  showLabel: true,
                  // isReadOnly: true,
                  controller: model.warehouseItemBarcodeController,
                  suffixWidget: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // added line
                    mainAxisSize: MainAxisSize.min, // added line
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.document_scanner_outlined),
                      ),
                      IconButton(
                        onPressed: context.read<SkladViewModel>().randomBarcode,
                        icon: const Icon(Icons.shuffle_on_rounded),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: getW(100),
                  child: Row(
                    children: [
                      Container(
                        height: getW(100),
                        width: getW(100),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30),
                          // color: const Color.fromRGBO(28, 28, 29, 1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/temp.png',
                              height: getW(100),
                              width: getW(100),
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.delete_outline_rounded,
                                  // size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: getW(100),
                        width: getW(100),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(28, 28, 29, 1),
                          // border: Border.all(color: Colors.white30),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_rounded,
                              size: 40,
                              color: Color.fromRGBO(114, 119, 122, 1),
                            ),
                            Text(
                              'Фото',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(114, 119, 122, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Spacer(),
                // Column(
                //   children: [
                //     SizedBox(
                //       height: getW(40),
                //       child: ListView.separated(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: 20,
                //         separatorBuilder: (context, index) {
                //           return const SizedBox(width: 4);
                //         },
                //         itemBuilder: (context, index) {
                //           return Container(
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 16,
                //               vertical: 8,
                //             ),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(32),
                //               color: index == 0
                //                   ? const Color(0xff34c85a)
                //                   : const Color(0xff262629),
                //             ),
                //             child: Text(
                //               'Ichki teg ${Random().nextInt(100)}',
                //               style: const TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 16,
                //               ),
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //     SizedBox(height: getW(4)),
                //     SizedBox(
                //       height: getW(40),
                //       child: ListView.separated(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: 3,
                //         separatorBuilder: (context, index) {
                //           return const SizedBox(width: 4);
                //         },
                //         itemBuilder: (context, index) {
                //           return Container(
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 16,
                //               vertical: 8,
                //             ),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(32),
                //               color: index == 2
                //                   ? const Color(0xff34c85a)
                //                   : const Color(0xff262629),
                //             ),
                //             child: const Text(
                //               'Asosiy teg',
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 16,
                //               ),
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 10),
                MainButtonWidget(
                  isLoading:
                      context.watch<SkladViewModel>().isCreatingWarehouseItem,
                  text: 'Сохранить',
                  method: () async {
                    if (formKey.currentState!.validate()) {
                      final res = await model.createWarehouseItem();
                      if (res) {
                        await model.getWarehouseItems();
                        await showModal(context, [
                          const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Товар добавлено',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          MainButtonWidget(
                            isLoading: false,
                            text: 'OK',
                            method: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(height: 40),
                        ]);
                      }
                    }
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
