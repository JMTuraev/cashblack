import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view_models/business/business_dashboard_view_model.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/main_button_widget.dart';
import '../../../../../widgets/multiline_text_field_widget.dart';
import '../../../../../widgets/show_modal.dart';
import '../../../../../widgets/text_field_widget.dart';

class CreateWarehouseCategoryView extends StatefulWidget {
  const CreateWarehouseCategoryView({super.key});

  @override
  State<CreateWarehouseCategoryView> createState() =>
      _CreateWarehouseCategoryViewState();
}

class _CreateWarehouseCategoryViewState
    extends State<CreateWarehouseCategoryView> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<SkladViewModel>().clearWarehouseCategoryCreating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    final modelUser = context.read<BusinessDashboardViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create category'),
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
                  controller: model.warehouseCategoryNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MultilineTextFieldWidget(
                  hintText: 'Описание',
                  // showLabel: true,

                  controller: model.warehouseCategoryTitleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 10),
                // TextFieldWidget(
                //   hintText: 'Email/Telegram',
                //   showLabel: true,
                //   controller: model.warehouseProviderEmailController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Заполните поле';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 10),
                const Spacer(),
                MainButtonWidget(
                  text: 'Сохранить',
                  method: () async {
                    if (formKey.currentState!.validate()) {
                      final res = await model.createWarehouseCategory();
                      if (res) {
                        await model.getWarehouseCategories();
                        await showModal(context, [
                          const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Категория добавлено',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          MainButtonWidget(
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
