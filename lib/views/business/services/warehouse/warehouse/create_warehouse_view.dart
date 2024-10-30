import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view_models/business/business_dashboard_view_model.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/main_button_widget.dart';
import '../../../../../widgets/show_modal.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../../scanner_view/payment_phone_view.dart';

class CreateWarehouseView extends StatefulWidget {
  const CreateWarehouseView({super.key});

  @override
  State<CreateWarehouseView> createState() => _CreateWarehouseViewState();
}

class _CreateWarehouseViewState extends State<CreateWarehouseView> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<SkladViewModel>().clearWarehouseCreating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    final modelUser = context.read<BusinessDashboardViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать склад'),
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
                  hintText: 'Наименование склада',
                  showLabel: true,
                  controller: model.warehouseNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  hintText: 'Адрес',
                  showLabel: true,
                  controller: model.warehouseAddressController,
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
                  selectedOption: model.selectedWarehouseShop,
                  categoryItems: [
                    const DropdownMenuItem(
                      value: '0',
                      enabled: false,
                      child: Text('Выберите магазин'),
                    ),
                    ...modelUser.businessShops!.map(
                      (e) => DropdownMenuItem(
                        value: e.id.toString(),
                        child: Text(e.name),
                      ),
                    ),
                  ],
                  onChanged: (String value) {
                    model.selectedWarehouseShop = value;
                  },
                  hint: 'Магазин',
                ),
                // const SizedBox(height: 10),
                const Spacer(),
                MainButtonWidget(
                  isLoading:
                      context.watch<SkladViewModel>().isCreatingWarehouse,
                  text: 'Сохранить',
                  method: () async {
                    if (formKey.currentState!.validate()) {
                      final res = await model.createWarehouse(
                        context,
                      );
                      if (res) {
                        await model.getWarehouses();
                        await showModal(context, [
                          const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Склад добавлено',
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
