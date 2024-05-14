import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../string_extensions.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/date_picker_widget.dart';
import '../../../../../widgets/main_button_widget.dart';
import '../../../../../widgets/show_modal.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../../scanner_view/payment_phone_view.dart';

class RasxodView extends StatefulWidget {
  const RasxodView({
    super.key,
  });

  @override
  State<RasxodView> createState() => _RasxodViewState();
}

class _RasxodViewState extends State<RasxodView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<SkladViewModel>().clearRasxodFields();
    super.initState();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    model.serialNumberController.text = Random().nextInt(999999999).toString();
    model.partyNumberController.text =
        "AB${Random().nextInt(99999)}${DateTime.now().toString().removeAllSymbols()}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Расход'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(
                  //   child: ToggleSwitch(
                  //     // inactiveBgColor: isDark ? Colors.white24 : AppColors.whiteColor,
                  //     // activeBgColor: const [
                  //     //   AppColors.mainColor,
                  //     // ],
                  //     activeFgColor: Colors.white,
                  //     totalSwitches: 2,
                  //     labels: const [
                  //       'Добавить',
                  //       'Список',
                  //     ],
                  //     centerText: true,
                  //     // icons: const [],
                  //     iconSize: 26,
                  //     onToggle: (index) {
                  //       selectedIndex = index ?? 0;
                  //       setState(() {});
                  //     },
                  //     // dividerColor: isDark ? Colors.white : AppColors.mainColor,
                  //     customWidths: [
                  //       SizeConfig.screenWidth / 2.3,
                  //       SizeConfig.screenWidth / 2.3,
                  //     ],
                  //     initialLabelIndex: selectedIndex,
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  selectedIndex == 0
                      ? Column(
                          children: [
                            TextFieldWidget(
                              hintText: 'Клиент',
                              showLabel: true,
                              controller: model.clientNameController,
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
                              selectedOption: model.selectedSkladItem,
                              categoryItems: [
                                const DropdownMenuItem(
                                  value: '0',
                                  enabled: false,
                                  child: Text('Выберите товар'),
                                ),
                                ...model.skladItems.map(
                                  (e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Column(
                                      children: [
                                        Text(e.name),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (String value) {
                                model.selectedSkladItem = value;
                                model.priceRasxodController.text = model
                                    .skladItems
                                    .where((element) => element.id == value)
                                    .first
                                    .priceSell
                                    .getFormattedNumber();
                                setState(() {});
                              },
                              hint: 'Выберите товар',
                            ),
                            const SizedBox(height: 10),
                            model.selectedSkladItem != null
                                ? Column(
                                    children: [
                                      const Text(
                                        'Остаток',
                                        style: TextStyle(
                                          color: Color(0xff667084),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        // 'Серия',
                                        '${model.skladItems.where(
                                              (element) =>
                                                  element.id ==
                                                  model.selectedSkladItem,
                                            ).first.quantity.getFormattedNumber()} ${model.skladItems.where(
                                              (element) =>
                                                  element.id ==
                                                  model.selectedSkladItem,
                                            ).first.attribute}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Divider(),
                                      const Text(
                                        'Серия',
                                        style: TextStyle(
                                          color: Color(0xff667084),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        model.skladItems
                                            .where(
                                              (element) =>
                                                  element.id ==
                                                  model.selectedSkladItem,
                                            )
                                            .first
                                            .serialNumber,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Divider(),
                                      const Text(
                                        'Цена прихода',
                                        style: TextStyle(
                                          color: Color(0xff667084),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        model.skladItems
                                            .where(
                                              (element) =>
                                                  element.id ==
                                                  model.selectedSkladItem,
                                            )
                                            .first
                                            .pricePrixod
                                            .getFormattedNumber(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Divider(),
                                      const Text(
                                        'Цена продажи',
                                        style: TextStyle(
                                          color: Color(0xff667084),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        model.skladItems
                                            .where(
                                              (element) =>
                                                  element.id ==
                                                  model.selectedSkladItem,
                                            )
                                            .first
                                            .priceSell
                                            .getFormattedNumber(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  )
                                : const SizedBox(),
                            TextFieldWidget(
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  model.priceSumOfRasxodController.clear();
                                } else {
                                  model.priceSumOfRasxodController
                                      .text = (int.parse(
                                            model.priceRasxodController.text
                                                .removeWhitespace(),
                                          ) *
                                          int.parse(value.removeWhitespace()))
                                      .toString()
                                      .getFormattedNumber();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Заполните поле';
                                } else if (int.parse(value.removeWhitespace()) >
                                    int.parse(
                                      model.skladItems
                                          .where(
                                            (element) =>
                                                element.id ==
                                                model.selectedSkladItem,
                                          )
                                          .first
                                          .quantity
                                          .removeWhitespace(),
                                    )) {
                                  return 'Количество больше чем на складе';
                                }
                                return null;
                              },
                              hintText: 'Количество',
                              showLabel: true,
                              textType: TextInputType.number,
                              controller: model.quantityRasxodController,
                            ),
                            const SizedBox(height: 10),
                            TextFieldWidget(
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  model.priceSumOfRasxodController.clear();
                                } else {
                                  model.priceSumOfRasxodController
                                      .text = (int.parse(
                                            model.quantityRasxodController.text
                                                .removeWhitespace(),
                                          ) *
                                          int.parse(value.removeWhitespace()))
                                      .toString()
                                      .getFormattedNumber();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Заполните поле';
                                }
                                return null;
                              },
                              hintText: 'Цена продажи одной единицы',
                              showLabel: true,
                              textType: TextInputType.number,
                              controller: model.priceRasxodController,
                            ),
                            const SizedBox(height: 10),
                            TextFieldWidget(
                              hintText:
                                  'Общая цена (Количество * Цена продажи)',
                              showLabel: true,
                              isReadOnly: true,
                              controller: model.priceSumOfRasxodController,
                            ),
                            const SizedBox(height: 10),
                            DatePickerWidget(
                              isDark: true,
                              title:
                                  context.watch<SkladViewModel>().raxsodDate ==
                                          null
                                      ? 'Дата и время продажи'
                                      : model.raxsodDate
                                          .toString()
                                          .getLocaleDateTime(),
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 60)),
                                ).then((value) async {
                                  if (value != null) {
                                    final date = value;
                                    await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          model.raxsodDate = date
                                              .add(
                                                Duration(
                                                  hours: value.hour,
                                                  minutes: value.minute,
                                                ),
                                              )
                                              .toString();
                                          // startDateTextController.text = selectedDate.toString().getLocaleDate();
                                        });
                                      }
                                    });
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            const SizedBox(height: 10),
                            MainButtonWidget(
                              text: 'Сохранить',
                              method: () {
                                // if (formKey.currentState!.validate()) {
                                //   model.addToSklad();
                                //   showModal(context, [
                                //     const SizedBox(
                                //       width: double.infinity,
                                //       child: Center(
                                //         child: Text(
                                //           'Товар добавлено в список',
                                //           style: TextStyle(
                                //             fontSize: 20,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     // const SizedBox(height: 10),
                                //     // TextButton(
                                //     //   onPressed: () {
                                //     //     Navigator.pop(context);
                                //     //     selectedIndex = 1;
                                //     //     setState(() {});
                                //     //   },
                                //     //   child: const Text('Показать список'),
                                //     // ),
                                //     const SizedBox(height: 10),
                                //     MainButtonWidget(
                                //       text: 'OK',
                                //       method: () {
                                //         model.clearFields();
                                //         Navigator.pop(context);
                                //         Navigator.pop(context);
                                //       },
                                //     ),
                                //     const SizedBox(height: 40),
                                //   ]);
                                // }
                              },
                            ),
                            const SizedBox(height: 40),
                          ],
                        )
                      : const SizedBox(),
                  selectedIndex == 1
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: model.skladItems.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      // Checkbox(
                                      //   value: false,
                                      //   // value: widget.selections.contains(index),
                                      //   onChanged: (value) {
                                      //     // setState(() {
                                      //     //   if (widget.selections.contains(index)) {
                                      //     //     widget.selections.remove(index);
                                      //     //   } else {
                                      //     //     widget.selections.add(index);
                                      //     //   }
                                      //     // });
                                      //   },
                                      // ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            model.skladItems[index].name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            model.warehouseCategories
                                                .where(
                                                  (element) =>
                                                      element.id.toString() ==
                                                      model.skladItems[index]
                                                          .category,
                                                )
                                                .first
                                                .name,
                                            style: const TextStyle(
                                              color: Color(0xff667084),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${model.skladItems[index].quantity} ${model.skladItems[index].attribute}',
                                        style: const TextStyle(
                                          color: Color(0xff34c85a),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const SizedBox(height: 40),
                                    ],
                                  );
                                },
                              ),
                            ),
                            MainButtonWidget(
                              text: 'Сохранить',
                              method: () {
                                model.addPrixod();
                                showModal(context, [
                                  const SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Сохранено',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(height: 10),
                                  // TextButton(
                                  //   onPressed: () {
                                  //     Navigator.pop(context);
                                  //     selectedIndex = 1;
                                  //     model.clearFields();
                                  //     setState(() {});
                                  //   },
                                  //   child: const Text('Показать список'),
                                  // ),
                                  const SizedBox(height: 10),
                                  MainButtonWidget(
                                    text: 'OK',
                                    method: () {
                                      model
                                        ..clearFields()
                                        ..clearSkladItems();
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(height: 40),
                                ]);
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
