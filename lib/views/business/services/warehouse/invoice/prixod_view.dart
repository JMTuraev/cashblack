// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../../string_extensions.dart';
// import '../../../../../view_models/sklad/sklad_view_model.dart';
// import '../../../../../widgets/date_picker_widget.dart';
// import '../../../../../widgets/main_button_widget.dart';
// import '../../../../../widgets/show_modal.dart';
// import '../../../../../widgets/text_field_widget.dart';
// import '../../../scanner_view/payment_phone_view.dart';

// class PrixodView extends StatefulWidget {
//   const PrixodView({
//     super.key,
//   });

//   @override
//   State<PrixodView> createState() => _PrixodViewState();
// }

// class _PrixodViewState extends State<PrixodView> {
//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     context.read<SkladViewModel>().clearFields();
//     super.initState();
//   }

//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final model = context.read<SkladViewModel>();
//     model.serialNumberController.text = Random().nextInt(999999999).toString();
//     model.partyNumberController.text =
//         "AB${Random().nextInt(99999)}${DateTime.now().toString().removeAllSymbols()}";

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Приход'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Center(
//                   //   child: ToggleSwitch(
//                   //     // inactiveBgColor: isDark ? Colors.white24 : AppColors.whiteColor,
//                   //     // activeBgColor: const [
//                   //     //   AppColors.mainColor,
//                   //     // ],
//                   //     activeFgColor: Colors.white,
//                   //     totalSwitches: 2,
//                   //     labels: const [
//                   //       'Добавить',
//                   //       'Список',
//                   //     ],
//                   //     centerText: true,
//                   //     // icons: const [],
//                   //     iconSize: 26,
//                   //     onToggle: (index) {
//                   //       selectedIndex = index ?? 0;
//                   //       setState(() {});
//                   //     },
//                   //     // dividerColor: isDark ? Colors.white : AppColors.mainColor,
//                   //     customWidths: [
//                   //       SizeConfig.screenWidth / 2.3,
//                   //       SizeConfig.screenWidth / 2.3,
//                   //     ],
//                   //     initialLabelIndex: selectedIndex,
//                   //   ),
//                   // ),
//                   const SizedBox(height: 10),
//                   selectedIndex == 0
//                       ? Column(
//                           children: [
//                             TextFieldWidget(
//                               hintText: 'Наименование товара',
//                               showLabel: true,
//                               controller: model.nameController,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Заполните поле';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 10),
//                             TextFieldWidget(
//                               hintText: 'Аттрибут',
//                               showLabel: true,
//                               controller: model.attributeController,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Заполните поле';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 10),
//                             SelectCategoryWidget(
//                               validator: (value) {
//                                 if (value == null || value == '0') {
//                                   return 'Выберите поле';
//                                 }
//                                 return null;
//                               },
//                               selectedOption: model.selectedCategory,
//                               categoryItems: [
//                                 const DropdownMenuItem(
//                                   value: '0',
//                                   enabled: false,
//                                   child: Text('Выберите категорию'),
//                                 ),
//                                 ...model.warehouseCategories.map(
//                                   (e) => DropdownMenuItem(
//                                     value: e.id.toString(),
//                                     child: Text(e.name),
//                                   ),
//                                 ),
//                               ],
//                               onChanged: (String value) {
//                                 model.selectedCategory = value;
//                               },
//                               hint: 'Категория',
//                             ),
//                             const SizedBox(height: 10),
//                             // SelectCategoryWidget(
//                             //   selectedOption: model.selectedSubCategory,
//                             //   validator: (value) {
//                             //     if (value == null || value == '0') {
//                             //       return 'Выберите поле';
//                             //     }
//                             //     return null;
//                             //   },
//                             //   categoryItems: [
//                             //     const DropdownMenuItem(
//                             //       value: '0',
//                             //       enabled: false,
//                             //       child: Text('Выберите cубкатегорию'),
//                             //     ),
//                             //     ...model.skladSubcatogies.map(
//                             //       (e) => DropdownMenuItem(
//                             //         value: e.value,
//                             //         child: Text(e.name),
//                             //       ),
//                             //     ),
//                             //   ],
//                             //   onChanged: (String value) {
//                             //     model.selectedSubCategory = value;
//                             //   },
//                             //   hint: 'Субкатегория',
//                             // ),
//                             // const SizedBox(height: 10),
//                             DatePickerWidget(
//                               isDark: true,
//                               title:
//                                   context.watch<SkladViewModel>().createdDate ==
//                                           null
//                                       ? 'Дата и время прихода'
//                                       : model.createdDate
//                                           .toString()
//                                           .getLocaleDateTime(),
//                               onTap: () async {
//                                 await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime.now(),
//                                   lastDate: DateTime.now()
//                                       .add(const Duration(days: 60)),
//                                 ).then((value) async {
//                                   if (value != null) {
//                                     final date = value;
//                                     await showTimePicker(
//                                       context: context,
//                                       initialTime: TimeOfDay.now(),
//                                     ).then((value) {
//                                       if (value != null) {
//                                         setState(() {
//                                           model.createdDate = date
//                                               .add(
//                                                 Duration(
//                                                   hours: value.hour,
//                                                   minutes: value.minute,
//                                                 ),
//                                               )
//                                               .toString();
//                                           // startDateTextController.text = selectedDate.toString().getLocaleDate();
//                                         });
//                                       }
//                                     });
//                                   }
//                                 });
//                               },
//                             ),
//                             const SizedBox(height: 10),
//                             TextFieldWidget(
//                               onChanged: (value) {
//                                 if (value.isEmpty) {
//                                   model.priceSumOfAllController.clear();
//                                 } else {
//                                   model.priceSumOfAllController
//                                       .text = (int.parse(
//                                             model.priceSellController.text
//                                                 .removeWhitespace(),
//                                           ) *
//                                           int.parse(value.removeWhitespace()))
//                                       .toString()
//                                       .getFormattedNumber();
//                                 }
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Заполните поле';
//                                 }
//                                 return null;
//                               },
//                               hintText: 'Общее количество',
//                               showLabel: true,
//                               textType: TextInputType.number,
//                               controller: model.quantityController,
//                             ),
//                             const SizedBox(height: 10),
//                             TextFieldWidget(
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Заполните поле';
//                                 }
//                                 return null;
//                               },
//                               hintText: 'Цена прихода одной единицы',
//                               showLabel: true,
//                               textType: TextInputType.number,
//                               controller: model.pricePrixodController,
//                             ),
//                             const SizedBox(height: 10),
//                             TextFieldWidget(
//                               onChanged: (value) {
//                                 if (value.isEmpty) {
//                                   model.priceSumOfAllController.clear();
//                                 } else {
//                                   model.priceSumOfAllController
//                                       .text = (int.parse(
//                                             model.quantityController.text
//                                                 .removeWhitespace(),
//                                           ) *
//                                           int.parse(value.removeWhitespace()))
//                                       .toString()
//                                       .getFormattedNumber();
//                                 }
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Заполните поле';
//                                 }
//                                 return null;
//                               },
//                               hintText: 'Цена продажи одной единицы',
//                               showLabel: true,
//                               textType: TextInputType.number,
//                               controller: model.priceSellController,
//                             ),
//                             const SizedBox(height: 10),
//                             TextFieldWidget(
//                               hintText:
//                                   'Общая цена (Количество * Цена продажи)',
//                               showLabel: true,
//                               isReadOnly: true,
//                               controller: model.priceSumOfAllController,
//                             ),
//                             const SizedBox(height: 10),
//                             TextFieldWidget(
//                               hintText: 'Серия',
//                               showLabel: true,
//                               isReadOnly: true,
//                               controller: model.serialNumberController,
//                             ),
//                             const SizedBox(height: 10),
//                             TextFieldWidget(
//                               hintText: 'Партия',
//                               showLabel: true,
//                               isReadOnly: true,
//                               controller: model.partyNumberController,
//                             ),
//                             const SizedBox(height: 10),
//                             SelectCategoryWidget(
//                               validator: (value) {
//                                 if (value == null || value == '0') {
//                                   return 'Выберите поле';
//                                 }
//                                 return null;
//                               },
//                               selectedOption: model.selectedDeliever,
//                               categoryItems: [
//                                 const DropdownMenuItem(
//                                   value: '0',
//                                   enabled: false,
//                                   child: Text('Выберите поставщик'),
//                                 ),
//                                 ...model.warehouseProviders.map(
//                                   (e) => DropdownMenuItem(
//                                     value: e.id.toString(),
//                                     child: Text(e.name),
//                                   ),
//                                 ),
//                               ],
//                               onChanged: (String value) {
//                                 model.selectedDeliever = value;
//                               },
//                               hint: 'Поставщик',
//                             ),
//                             const SizedBox(height: 10),
//                             SelectCategoryWidget(
//                               validator: (value) {
//                                 if (value == null || value == '0') {
//                                   return 'Выберите поле';
//                                 }
//                                 return null;
//                               },
//                               selectedOption: model.selectedSkladItemStatus,
//                               categoryItems: [
//                                 const DropdownMenuItem(
//                                   value: '0',
//                                   enabled: false,
//                                   child: Text('Выберите cтатус товара'),
//                                 ),
//                                 ...model.skladItemStatuses.map(
//                                   (e) => DropdownMenuItem(
//                                     value: e.value,
//                                     child: Text(e.name),
//                                   ),
//                                 ),
//                               ],
//                               onChanged: (String value) {
//                                 model.selectedSkladItemStatus = value;
//                               },
//                               hint: 'Статус товара',
//                             ),
//                             const SizedBox(height: 10),
//                             TextFieldWidget(
//                               hintText: 'Порог оповещения о количестве',
//                               showLabel: true,
//                               textType: TextInputType.number,
//                               controller: model.minQuantityController,
//                             ),
//                             const SizedBox(height: 10),
//                             MainButtonWidget(
//                               text: 'Сохранить',
//                               method: () {
//                                 if (formKey.currentState!.validate()) {
//                                   model.addToSklad();
//                                   showModal(context, [
//                                     const SizedBox(
//                                       width: double.infinity,
//                                       child: Center(
//                                         child: Text(
//                                           'Товар добавлено в список',
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     // const SizedBox(height: 10),
//                                     // TextButton(
//                                     //   onPressed: () {
//                                     //     Navigator.pop(context);
//                                     //     selectedIndex = 1;
//                                     //     setState(() {});
//                                     //   },
//                                     //   child: const Text('Показать список'),
//                                     // ),
//                                     const SizedBox(height: 10),
//                                     MainButtonWidget(
//                                       text: 'OK',
//                                       method: () {
//                                         model.clearFields();
//                                         Navigator.pop(context);
//                                         Navigator.pop(context);
//                                       },
//                                     ),
//                                     const SizedBox(height: 40),
//                                   ]);
//                                 }
//                               },
//                             ),
//                             const SizedBox(height: 40),
//                           ],
//                         )
//                       : const SizedBox(),
//                   selectedIndex == 1
//                       ? Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(20),
//                               child: ListView.separated(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: model.skladItems.length,
//                                 separatorBuilder: (context, index) {
//                                   return const SizedBox(height: 10);
//                                 },
//                                 itemBuilder: (context, index) {
//                                   return Row(
//                                     children: [
//                                       // Checkbox(
//                                       //   value: false,
//                                       //   // value: widget.selections.contains(index),
//                                       //   onChanged: (value) {
//                                       //     // setState(() {
//                                       //     //   if (widget.selections.contains(index)) {
//                                       //     //     widget.selections.remove(index);
//                                       //     //   } else {
//                                       //     //     widget.selections.add(index);
//                                       //     //   }
//                                       //     // });
//                                       //   },
//                                       // ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Text(
//                                             model.skladItems[index].name,
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                           Text(
//                                             model.warehouseCategories
//                                                 .where(
//                                                   (element) =>
//                                                       element.id.toString() ==
//                                                       model.skladItems[index]
//                                                           .category,
//                                                 )
//                                                 .first
//                                                 .name,
//                                             style: const TextStyle(
//                                               color: Color(0xff667084),
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const Spacer(),
//                                       Text(
//                                         '${model.skladItems[index].quantity} ${model.skladItems[index].attribute}',
//                                         style: const TextStyle(
//                                           color: Color(0xff34c85a),
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       const SizedBox(height: 40),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ),
//                             MainButtonWidget(
//                               text: 'Сохранить',
//                               method: () {
//                                 model.addPrixod();
//                                 showModal(context, [
//                                   const SizedBox(
//                                     width: double.infinity,
//                                     child: Center(
//                                       child: Text(
//                                         'Сохранено',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   // const SizedBox(height: 10),
//                                   // TextButton(
//                                   //   onPressed: () {
//                                   //     Navigator.pop(context);
//                                   //     selectedIndex = 1;
//                                   //     model.clearFields();
//                                   //     setState(() {});
//                                   //   },
//                                   //   child: const Text('Показать список'),
//                                   // ),
//                                   const SizedBox(height: 10),
//                                   MainButtonWidget(
//                                     text: 'OK',
//                                     method: () {
//                                       model
//                                         ..clearFields()
//                                         ..clearSkladItems();
//                                       setState(() {});
//                                       Navigator.pop(context);
//                                     },
//                                   ),
//                                   const SizedBox(height: 40),
//                                 ]);
//                               },
//                             ),
//                           ],
//                         )
//                       : const SizedBox(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
