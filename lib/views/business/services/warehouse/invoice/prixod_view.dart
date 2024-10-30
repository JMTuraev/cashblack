import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../../size_config.dart';
import '../../../../../string_extensions.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/main_button_widget.dart';
import '../../../../../widgets/show_modal.dart';
import '../../../../../widgets/text_field_widget.dart';
import '../../../scanner_view/payment_phone_view.dart';
import 'prixod_history_list_view.dart';

class PrixodView extends StatefulWidget {
  const PrixodView({
    super.key,
  });

  @override
  State<PrixodView> createState() => _PrixodViewState();
}

class _PrixodViewState extends State<PrixodView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<SkladViewModel>().clearFields();

    context.read<SkladViewModel>().prixodSerialNumberController.text =
        Random().nextInt(999999999).toString();
    // context.read<SkladViewModel>().partyNumberController.text =
    //     "AB${Random().nextInt(99999)}${DateTime.now().toString().removeAllSymbols()}";

    super.initState();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    final modelWatch = context.watch<SkladViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Приход'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const PrixodHistoryListView(),
                ),
              );
            },
            icon: const Icon(Icons.history),
          ),
        ],
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
                  Center(
                    child: ToggleSwitch(
                      // inactiveBgColor: isDark ? Colors.white24 : AppColors.whiteColor,
                      // activeBgColor: const [
                      //   AppColors.mainColor,
                      // ],
                      activeFgColor: Colors.white,
                      totalSwitches: 2,
                      labels: const [
                        'Добавить',
                        'Список',
                      ],
                      centerText: true,
                      // icons: const [],
                      iconSize: 26,
                      onToggle: (index) {
                        selectedIndex = index ?? 0;
                        setState(() {});
                      },
                      // dividerColor: isDark ? Colors.white : AppColors.mainColor,
                      customWidths: [
                        SizeConfig.screenWidth / 2.3,
                        SizeConfig.screenWidth / 2.3,
                      ],
                      initialLabelIndex: selectedIndex,
                    ),
                  ),
                  const SizedBox(height: 10),
                  selectedIndex == 0
                      ? Column(
                          children: [
                            SelectCategoryWidget(
                              validator: (value) {
                                if (value == null || value == '0') {
                                  return 'Выберите поле';
                                }
                                return null;
                              },
                              selectedOption: model.selectedPrixodCategory,
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
                                setState(() {
                                  model
                                    ..selectedPrixodCategory = value
                                    ..selectedPrixodProductItem = null;
                                });
                              },
                              hint: 'Категория',
                            ),
                            const SizedBox(height: 10),
                            SelectCategoryWidget(
                              validator: (value) {
                                if (value == null || value == '0') {
                                  return 'Выберите поле';
                                }
                                return null;
                              },
                              selectedOption:
                                  modelWatch.selectedPrixodProductItem,
                              categoryItems:
                                  modelWatch.selectedPrixodCategory == null
                                      ? []
                                      : [
                                          const DropdownMenuItem(
                                            value: '0',
                                            enabled: false,
                                            child: Text('Выберите товар'),
                                          ),
                                          ...model.warehouseItems
                                              // .where(
                                              //   (element) =>
                                              //       element.category.id
                                              //           .toString() ==
                                              //       modelWatch.selectedCategory,
                                              // )
                                              .map(
                                            (e) => DropdownMenuItem(
                                              value: e.id.toString(),
                                              child: Text(e.name),
                                            ),
                                          ),
                                        ],
                              onChanged: (String value) {
                                model.selectedPrixodProductItem = value;
                              },
                              hint: 'Наименование товара',
                            ),
                            const SizedBox(height: 10),
                            // SelectCategoryWidget(
                            //   validator: (value) {
                            //     if (value == null || value == '0') {
                            //       return 'Выберите поле';
                            //     }
                            //     return null;
                            //   },
                            //   selectedOption: model.selectedPrixodUnit,
                            //   categoryItems: [
                            //     const DropdownMenuItem(
                            //       value: '0',
                            //       enabled: false,
                            //       child: Text('Выберите аттрибут'),
                            //     ),
                            //     ...model.warehouseUnits.map(
                            //       (e) => DropdownMenuItem(
                            //         value: e.id.toString(),
                            //         child: Text(e.title),
                            //       ),
                            //     ),
                            //   ],
                            //   onChanged: (String value) {
                            //     model.selectedPrixodUnit = value;
                            //   },
                            //   hint: 'Аттрибут',
                            // ),
                            // const SizedBox(height: 10),
                            SelectCategoryWidget(
                              validator: (value) {
                                if (value == null || value == '0') {
                                  return 'Выберите поле';
                                }
                                return null;
                              },
                              selectedOption: model.selectedPrixodProvider,
                              categoryItems: [
                                const DropdownMenuItem(
                                  value: '0',
                                  enabled: false,
                                  child: Text('Выберите поставщик'),
                                ),
                                ...model.warehouseProviders.map(
                                  (e) => DropdownMenuItem(
                                    value: e.id.toString(),
                                    child: Text(e.name),
                                  ),
                                ),
                              ],
                              onChanged: (String value) {
                                model.selectedPrixodProvider = value;
                              },
                              hint: 'Поставщик',
                            ),
                            const SizedBox(height: 10),
                            SelectCategoryWidget(
                              validator: (value) {
                                if (value == null || value == '0') {
                                  return 'Выберите поле';
                                }
                                return null;
                              },
                              selectedOption: model.selectedPrixodUnit,
                              categoryItems: [
                                const DropdownMenuItem(
                                  value: '0',
                                  enabled: false,
                                  child: Text('Выберите склад'),
                                ),
                                ...model.warehouses.map(
                                  (e) => DropdownMenuItem(
                                    value: e.id.toString(),
                                    child: Text(e.name),
                                  ),
                                ),
                              ],
                              onChanged: (String value) {
                                model.selectedPrixodWarehouse = value;
                              },
                              hint: 'Склад',
                            ),
                            const SizedBox(height: 10),

                            // SelectCategoryWidget(
                            //   selectedOption: model.selectedSubCategory,
                            //   validator: (value) {
                            //     if (value == null || value == '0') {
                            //       return 'Выберите поле';
                            //     }
                            //     return null;
                            //   },
                            //   categoryItems: [
                            //     const DropdownMenuItem(
                            //       value: '0',
                            //       enabled: false,
                            //       child: Text('Выберите cубкатегорию'),
                            //     ),
                            //     ...model.skladSubcatogies.map(
                            //       (e) => DropdownMenuItem(
                            //         value: e.value,
                            //         child: Text(e.name),
                            //       ),
                            //     ),
                            //   ],
                            //   onChanged: (String value) {
                            //     model.selectedSubCategory = value;
                            //   },
                            //   hint: 'Субкатегория',
                            // ),
                            // const SizedBox(height: 10),
                            // DatePickerWidget(
                            //   isDark: true,
                            //   title: context
                            //               .watch<SkladViewModel>()
                            //               .prixodCreatedDate ==
                            //           null
                            //       ? 'Дата и время прихода'
                            //       : model.prixodCreatedDate
                            //           .toString()
                            //           .getLocaleDateTime(),
                            //   onTap: () async {
                            //     await showDatePicker(
                            //       context: context,
                            //       initialDate: DateTime.now(),
                            //       firstDate: DateTime.now(),
                            //       lastDate: DateTime.now()
                            //           .add(const Duration(days: 60)),
                            //     ).then((value) async {
                            //       if (value != null) {
                            //         final date = value;
                            //         await showTimePicker(
                            //           context: context,
                            //           initialTime: TimeOfDay.now(),
                            //         ).then((value) {
                            //           if (value != null) {
                            //             setState(() {
                            //               model.prixodCreatedDate = date
                            //                   .add(
                            //                     Duration(
                            //                       hours: value.hour,
                            //                       minutes: value.minute,
                            //                     ),
                            //                   )
                            //                   .toString();
                            //               // startDateTextController.text = selectedDate.toString().getLocaleDate();
                            //             });
                            //           }
                            //         });
                            //       }
                            //     });
                            //   },
                            // ),
                            // const SizedBox(height: 10),
                            TextFieldWidget(
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  model.prixodPriceSumOfAllController.clear();
                                } else {
                                  model.prixodPriceSumOfAllController
                                      .text = (int.parse(
                                            model.prixodPriceBuyController.text
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
                              hintText: 'Общее количество',
                              showLabel: true,
                              textType: TextInputType.number,
                              controller: model.prixodQuantityController,
                            ),
                            const SizedBox(height: 10),
                            TextFieldWidget(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Заполните поле';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  model.prixodPriceSumOfAllController.clear();
                                } else {
                                  model.prixodPriceSumOfAllController
                                      .text = (int.parse(
                                            model.prixodQuantityController.text
                                                .removeWhitespace(),
                                          ) *
                                          int.parse(value.removeWhitespace()))
                                      .toString()
                                      .getFormattedNumber();
                                }
                              },
                              hintText: 'Цена прихода одной единицы',
                              showLabel: true,
                              textType: TextInputType.number,
                              controller: model.prixodPriceBuyController,
                            ),
                            const SizedBox(height: 10),
                            TextFieldWidget(
                              // onChanged: (value) {
                              //   if (value.isEmpty) {
                              //     model.prixodPriceSumOfAllController.clear();
                              //   } else {
                              //     model.prixodPriceSumOfAllController
                              //         .text = (int.parse(
                              //               model.prixodQuantityController.text
                              //                   .removeWhitespace(),
                              //             ) *
                              //             int.parse(value.removeWhitespace()))
                              //         .toString()
                              //         .getFormattedNumber();
                              //   }
                              // },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Заполните поле';
                                }
                                return null;
                              },
                              hintText: 'Цена продажи одной единицы',
                              showLabel: true,
                              textType: TextInputType.number,
                              controller: model.prixodPriceSellController,
                            ),
                            const SizedBox(height: 10),
                            TextFieldWidget(
                              hintText:
                                  'Общая цена (Количество * Цена прихода)',
                              showLabel: true,
                              isReadOnly: true,
                              controller: model.prixodPriceSumOfAllController,
                            ),
                            const SizedBox(height: 10),
                            TextFieldWidget(
                              hintText: 'Серия',
                              showLabel: true,
                              isReadOnly: true,
                              controller: model.prixodSerialNumberController,
                            ),
                            const SizedBox(height: 10),
                            // TextFieldWidget(
                            //   hintText: 'Партия',
                            //   showLabel: true,
                            //   isReadOnly: true,
                            //   controller: model.partyNumberController,
                            // ),
                            // const SizedBox(height: 10),

                            // SelectCategoryWidget(
                            //   validator: (value) {
                            //     if (value == null || value == '0') {
                            //       return 'Выберите поле';
                            //     }
                            //     return null;
                            //   },
                            //   selectedOption: model.selectedSkladItemStatus,
                            //   categoryItems: [
                            //     const DropdownMenuItem(
                            //       value: '0',
                            //       enabled: false,
                            //       child: Text('Выберите cтатус товара'),
                            //     ),
                            //     ...model.skladItemStatuses.map(
                            //       (e) => DropdownMenuItem(
                            //         value: e.value,
                            //         child: Text(e.name),
                            //       ),
                            //     ),
                            //   ],
                            //   onChanged: (String value) {
                            //     model.selectedSkladItemStatus = value;
                            //   },
                            //   hint: 'Статус товара',
                            // ),
                            // const SizedBox(height: 10),
                            // TextFieldWidget(
                            //   hintText: 'Порог оповещения о количестве',
                            //   showLabel: true,
                            //   textType: TextInputType.number,
                            //   controller: model.minQuantityController,
                            // ),
                            // const SizedBox(height: 10),
                            MainButtonWidget(
                              isLoading: false,
                              text: 'Добавить',
                              method: () {
                                if (formKey.currentState!.validate()) {
                                  model.addToSklad();
                                  showModal(context, [
                                    const SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          'Товар добавлено в список',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        selectedIndex = 1;
                                        setState(() {});
                                      },
                                      child: const Text('Показать список'),
                                    ),
                                    const SizedBox(height: 10),
                                    MainButtonWidget(
                                      isLoading: false,
                                      text: 'OK',
                                      method: () {
                                        model.clearFields();
                                        // Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const SizedBox(height: 40),
                                  ]);
                                }
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
                                itemCount: model.prixodItemsForCreate.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                                itemBuilder: (context, index) {
                                  final unitname = model.warehouseItems
                                      .where(
                                        (element) =>
                                            element.id.toString() ==
                                            model.prixodItemsForCreate[index]
                                                .productiId,
                                      )
                                      .first
                                      .unit
                                      .title;
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
                                            model.warehouseItems
                                                .where(
                                                  (element) =>
                                                      element.id.toString() ==
                                                      model
                                                          .prixodItemsForCreate[
                                                              index]
                                                          .productiId,
                                                )
                                                .first
                                                .name,
                                            // model.prixodItemsForCreate[index]
                                            //     .productiId,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            model.prixodItemsForCreate[index]
                                                .price
                                                .getAmountInSum(),
                                            style: const TextStyle(
                                              color: Color(0xff667084),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${model.prixodItemsForCreate[index].quantity} $unitname',
                                            style: const TextStyle(
                                              color: Color(0xff34c85a),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            (int.parse(
                                                      model
                                                          .prixodItemsForCreate[
                                                              index]
                                                          .quantity,
                                                    ) *
                                                    double.parse(
                                                      model
                                                          .prixodItemsForCreate[
                                                              index]
                                                          .price,
                                                    ))
                                                .toString()
                                                .getAmountInSum(),
                                            style: const TextStyle(
                                              color: Color(0xff34c85a),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
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
                              isLoading: false,
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
                                    isLoading: false,
                                    text: 'OK',
                                    method: () {
                                      model
                                        ..clearFields()
                                        ..clearSkladItems()
                                        ..getRemainingItems();

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
