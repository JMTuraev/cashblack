import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view_models/business/business_dashboard_view_model.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/main_button_widget.dart';
import '../../../../../widgets/show_modal.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../../scanner_view/payment_phone_view.dart';

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
    final random = Random();
    const min = 100000000;
    const max = 999999999;
    const min2 = 1000;
    const max2 = 9999;
    //  min + random.nextInt(max - min + 1);
    context.read<SkladViewModel>().clearWarehouseItemCreating();
    context.read<SkladViewModel>().warehouseItemBarcodeController.text =
        // Random().nextInt(999999999).toString() +
        //     Random().nextInt(9999).toString();
        (min + random.nextInt(max - min + 1)).toString() +
            (min2 + random.nextInt(max2 - min2 + 1)).toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    final modelUser = context.read<BusinessDashboardViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create item'),
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
                    const DropdownMenuItem(
                      value: '0',
                      enabled: false,
                      child: Text('Выберите категорию'),
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
                TextFieldWidget(
                  hintText: 'Порог оповещения о количестве',
                  showLabel: true,
                  controller: model.warehouseItemLowerController,
                  textType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                TextFieldWidget(
                  hintText: 'Barcode',
                  showLabel: true,
                  isReadOnly: true,
                  controller: model.warehouseItemBarcodeController,
                ),
                const Spacer(),
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
