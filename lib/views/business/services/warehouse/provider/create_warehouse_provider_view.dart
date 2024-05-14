import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view_models/business/business_dashboard_view_model.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/main_button_widget.dart';
import '../../../../../widgets/show_modal.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../../../../widgets/text_field_with_phone_widget.dart';

class CreateWarehouseProviderView extends StatefulWidget {
  const CreateWarehouseProviderView({super.key});

  @override
  State<CreateWarehouseProviderView> createState() =>
      _CreateWarehouseProviderViewState();
}

class _CreateWarehouseProviderViewState
    extends State<CreateWarehouseProviderView> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<SkladViewModel>().clearWarehouseProviderCreating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    final modelUser = context.read<BusinessDashboardViewModel>();

    if (model.warehouseProviderPhoneController.text.length < 3) {
      model.warehouseProviderPhoneController.text = '+998';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create provider'),
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
                  hintText: 'Имя',
                  showLabel: true,
                  controller: model.warehouseProviderNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWithPhoneWidget(
                  hintText: 'Телефон',
                  showLabel: true,
                  controller: model.warehouseProviderPhoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  hintText: 'Email/Telegram',
                  showLabel: true,
                  controller: model.warehouseProviderEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 10),
                const Spacer(),
                MainButtonWidget(
                  text: 'Сохранить',
                  method: () async {
                    if (formKey.currentState!.validate()) {
                      final res = await model.createWarehouseProvider();
                      if (res) {
                        await model.getWarehouseProviders();
                        await showModal(context, [
                          const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Поставщик добавлено',
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
