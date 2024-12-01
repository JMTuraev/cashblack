// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/services/warehouse_item_for_kassa.dart';
import '../../../../size_config.dart';
import '../../../../string_extensions.dart';
import '../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/show_modal.dart';
import '../../../../widgets/text_field_widget.dart';
import '../../../../widgets/text_field_with_label_widget.dart';
import 'kassa_items_list_view.dart';

class KassaView extends StatefulWidget {
  const KassaView({
    super.key,
  });

  @override
  State<KassaView> createState() => _KassaViewState();
}

class _KassaViewState extends State<KassaView> {
  List<bool> isShow = [true, false, false];
  List<int> selections = [];
  // bool isAddition = true;

  @override
  void initState() {
    super.initState();
    context.read<SkladViewModel>().tempTotalSum = 0;
    context.read<SkladViewModel>().tempItemsForSale.clear();
    context.read<SkladViewModel>().tempItemsReset();
    selections.clear();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    final modelWatch = context.watch<SkladViewModel>();
    inspect(context.read<SkladViewModel>().tempItemsForSale);
    inspect(context.read<SkladViewModel>().tempItems);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Касса'),
        // leadingWidth: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (isShow[0]) {
                  // isShow = [false, true, false]; // todo
                  isShow = [false, false, true];
                } else if (isShow[1]) {
                  isShow = [false, false, true]; //todo no hozir
                } else if (isShow[2]) {
                  isShow = [true, false, false];
                }
              });
            },
            icon: const Icon(Icons.filter),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.grid_view_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: getW(50),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        TextFieldWithLabelWidget(
                          hintText: 'К-во',
                          radius: 10,
                          isCenter: true,
                          maxLength: 4,
                          showLength: false,
                          controller: model.tempCounterController,
                        ),
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () {
                              for (final element in selections) {
                                final item = model.tempItemsForSale
                                    .where((el) => el.id == element)
                                    .first;
                                if (item.count > 1) {
                                  item.count -= 1;
                                  model.tempTotalSum -= item.price;
                                }
                                // element.count += 1;
                                // model.tempTotalSum += element.price;
                              }
                              setState(() {});
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(left: 2),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(90),
                                  ),
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () {
                              for (final element in selections) {
                                final item = model.tempItemsForSale
                                    .where((el) => el.id == element)
                                    .first;
                                item.count += 1;
                                model.tempTotalSum += item.price;
                                // element.count += 1;
                                // model.tempTotalSum += element.price;
                              }
                              setState(() {});
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(right: 2),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(90),
                                  ),
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.add,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 2,
                    child: TextFieldWidget(
                      hintText: 'Штрих код',
                      radius: 10,
                      suffixWidget: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.document_scanner_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onDoubleTap: () {},
                    onTap: () async {
                      selections.clear();
                      setState(() {}); // TODOsetstate
                      final refresh = await Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const KassaItemsListView(),
                        ),
                      );
                      if (refresh == true) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: getW(56),
                      width: getW(56),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(90),
                        ),
                        color: Colors.green,
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/box-search.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isShow[0] == true
                  ? _ListWidget(
                      selections: selections,
                      items: model.tempItemsForSale,
                      onTap: () async {
                        // print(model.tempItemsForSale);
                        // await addPriceModal(context, model);
                      },
                    )
                  : isShow[1] == true
                      ? _GridWidget(
                          selections: selections,
                          items: model.tempItemsForSale,
                        )
                      : _GridExpandedWidget(
                          selections: selections,
                          items: model.tempItemsForSale,
                          onTap: () async {
                            // await addPriceModal(context, model);
                          },
                        ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x72000000),
                    blurRadius: 18,
                  ),
                ],
                color: const Color(0xff090a0a),
              ),
              child: Column(
                children: [
                  const Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Скидка: ',
                                style: TextStyle(
                                  color: Color(0xff72777a),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '0%',
                                style: TextStyle(
                                  color: Color(0xff34c85a),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'Итого: ',
                                style: TextStyle(
                                  color: Color(0xff72777a),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                modelWatch.tempTotalSum
                                    .toString()
                                    .getAmountInSum(),
                                style: const TextStyle(
                                  color: Color(0xff34c85a),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWithLabelWidget(hintText: 'Покупатель'),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.green,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(Icons.person),
                          // child: Text(
                          //   'JM',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MainButtonWidget(
                    isLoading: false,
                    text: 'Оплатить',
                    method: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> addPriceModal(BuildContext context, SkladViewModel model) async {
  //   await showModal(
  //     context,
  //     [
  //       StatefulBuilder(
  //         builder: (context, setState) {
  //           return Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   TextButton(
  //                     style: ButtonStyle(
  //                       foregroundColor: WidgetStateProperty.all<Color?>(
  //                         isAddition ? Colors.green : Colors.white,
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       isAddition = true;
  //                       model.tempAdditionController.clear();
  //                       setState(() {});
  //                     },
  //                     child: const Text(
  //                       'Наценка',
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                   TextButton(
  //                     onPressed: () {
  //                       isAddition = false;
  //                       model.tempAdditionController.clear();
  //                       setState(() {});
  //                     },
  //                     style: ButtonStyle(
  //                       foregroundColor: WidgetStateProperty.all<Color?>(
  //                         isAddition ? Colors.white : Colors.green,
  //                       ),
  //                     ),
  //                     child: const Text(
  //                       'Цена',
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 30),
  //               TextFieldWidget(
  //                 maxLength: isAddition ? 3 : null,
  //                 hintText: isAddition ? 'Наценка (%)' : 'Цена',
  //                 textType: TextInputType.number,
  //                 controller: model.tempAdditionController,
  //               ),
  //               const SizedBox(height: 20),
  //               const Row(
  //                 children: [
  //                   Text(
  //                     'Цена: ',
  //                     style: TextStyle(
  //                       color: Color(0xff72777a),
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                   Text(
  //                     // widget.items[index].price.toString().getAmountInSum(),
  //                     '123',
  //                     style: TextStyle(
  //                       color: Color(0xff34c85a),
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               const Row(
  //                 children: [
  //                   Text(
  //                     'Итог: ',
  //                     style: TextStyle(
  //                       color: Color(0xff72777a),
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                   Text(
  //                     // (widget.items[index].price * widget.items[index].count)
  //                     //     .toString()
  //                     //     .getAmountInSum(),
  //                     '123',

  //                     style: TextStyle(
  //                       color: Color(0xff34c85a),
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               const Row(
  //                 children: [
  //                   Text(
  //                     'Наценка: ',
  //                     style: TextStyle(
  //                       color: Color(0xff72777a),
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                   Text(
  //                     // '${widget.items[index].addition} %',
  //                     '123',

  //                     style: TextStyle(
  //                       color: Color(0xff34c85a),
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //       const SizedBox(height: 20),
  //       MainButtonWidget(
  //         isLoading: false,
  //         text: 'OK',
  //         method: () {
  //           Navigator.pop(context);
  //         },
  //       ),
  //       const SizedBox(height: 40),
  //     ],
  //     padding: 20,
  //   );
  // }
}

class _ListWidget extends StatefulWidget {
  const _ListWidget({
    super.key,
    required this.selections,
    required this.items,
    required this.onTap,
  });

  final List<int> selections;
  final List<WarehouseItemForKassa> items;
  final Function()? onTap;

  @override
  State<_ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<_ListWidget> {
  bool isAddition = true;

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    return ListView.separated(
      itemCount: widget.items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(),
          onTap: () async {
            model.tempAdditionController.clear();
            var newPrice = 0.0;

            await showModal(
              context,
              [
                StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    WidgetStateProperty.all<Color?>(
                                  isAddition ? Colors.green : Colors.white,
                                ),
                              ),
                              onPressed: () {
                                isAddition = true;
                                model.tempAdditionController.clear();
                                newPrice = 0.0;

                                setState(() {});
                              },
                              child: const Text(
                                'Наценка',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                isAddition = false;
                                model.tempAdditionController.clear();
                                newPrice = 0.0;
                                setState(() {});
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    WidgetStateProperty.all<Color?>(
                                  isAddition ? Colors.white : Colors.green,
                                ),
                              ),
                              child: const Text(
                                'Цена',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        TextFieldWidget(
                          maxLength: isAddition ? 3 : null,
                          hintText: isAddition ? 'Наценка (%)' : 'Цена',
                          textType: TextInputType.number,
                          controller: model.tempAdditionController,
                          onChanged: (p0) {
                            if (p0.isEmpty) {
                              p0 = '0';
                            } else {
                              if (isAddition) {
                                newPrice = widget.items[index].price +
                                    double.parse(p0) /
                                        100 *
                                        widget.items[index].price;
                              } else {
                                newPrice = double.parse(p0.removeWhitespace());
                              }
                            }
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text(
                              'Цена: ',
                              style: TextStyle(
                                color: Color(0xff72777a),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.items[index].price
                                  .toString()
                                  .getAmountInSum(),
                              style: const TextStyle(
                                color: Color(0xff34c85a),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              'Наценка: ',
                              style: TextStyle(
                                color: Color(0xff72777a),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              isAddition
                                  ? (model.tempAdditionController.text.isEmpty
                                      ? '0%'
                                      : '${model.tempAdditionController.text}%')
                                  : '${widget.items[index].addition}%',
                              style: const TextStyle(
                                color: Color(0xff34c85a),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              'Новая цена: ',
                              style: TextStyle(
                                color: Color(0xff72777a),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              newPrice.toString().getAmountInSum(),
                              // (widget.items[index].price *
                              //         widget.items[index].count)
                              //     .toString()
                              //     .getAmountInSum(),
                              style: const TextStyle(
                                color: Color(0xff34c85a),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                MainButtonWidget(
                  isLoading: false,
                  text: 'OK',
                  method: () {
                    final targetItem = model.tempItemsForSale
                        .where(
                          (element) => element.id == widget.items[index].id,
                        )
                        .first;

                    if (isAddition) {
                      widget.items[index].addition = double.parse(
                        model.tempAdditionController.text,
                      );
                      targetItem.addition = double.parse(
                        model.tempAdditionController.text,
                      );
                    } else {
                      widget.items[index].addition = 0.0;
                      targetItem.addition = 0.0;
                    }
                    widget.items[index].price = newPrice;
                    targetItem.price = newPrice;

                    // setState(() {});
                    Navigator.pop(context, true);
                  },
                ),
                const SizedBox(height: 40),
              ],
              padding: 20,
            ).then(
              (value) {
                model.tempTotalSum = 0;
                for (final element in model.tempItemsForSale) {
                  model.tempTotalSum += element.price;
                }
                setState(() {});
              },
            );
          },
          title: Row(
            children: [
              // Checkbox(
              //   value: widget.selections.contains(index),
              //   onChanged: (value) {
              //     setState(() {
              //       if (widget.selections.contains(index)) {
              //         widget.selections.remove(index);
              //       } else {
              //         widget.selections.add(index);
              //       }
              //     });
              //   },
              // ),
              // const SizedBox(width: 10),
              ClipOval(
                child: Image.asset(
                  // 'assets/images/notification/bo-10.png',
                  'assets/images/temp.png',
                  fit: BoxFit.cover,
                  height: getW(44),
                  width: getW(44),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.items[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.items[index].tags
                            .toString()
                            .removeFirstAndLastForTag(),
                        style: const TextStyle(
                          color: Color(0xff667084),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Цена:',
                        style: TextStyle(
                          color: Color(0xff72777a),
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        widget.items[index].price.toString().getAmountInSum(),
                        style: const TextStyle(
                          color: Color(0xff34c85a),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'x${widget.items[index].count.toString().getFormattedNumber()}',
                style: const TextStyle(
                  color: Color(0xff34c85a),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),

              _CustomCheckBox(
                selections: widget.selections,
                value: widget.selections.contains(widget.items[index].id),
                onTap: () {
                  setState(() {
                    if (widget.selections.contains(widget.items[index].id)) {
                      widget.selections.remove(widget.items[index].id);
                    } else {
                      widget.selections.add(widget.items[index].id);
                    }
                  });
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
        );
      },
    );
  }
}

class _GridWidget extends StatefulWidget {
  const _GridWidget({
    super.key,
    required this.selections,
    required this.items,
  });

  final List<int> selections;
  final List<WarehouseItemForKassa> items;

  @override
  State<_GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<_GridWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xff262629),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: getW(100),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.asset(
                        // 'assets/images/notification/bo-3.png',
                        'assets/images/temp.png',

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: _CustomCheckBox(
                      selections: widget.selections,
                      value: widget.selections.contains(widget.items[index].id),
                      onTap: () {
                        setState(() {
                          if (widget.selections
                              .contains(widget.items[index].id)) {
                            widget.selections.remove(widget.items[index].id);
                          } else {
                            widget.selections.add(widget.items[index].id);
                          }
                        });
                      },
                    ),
                    // child: IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.more_vert,
                    //     color: Colors.black87,
                    //   ),
                    // ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.items[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${widget.items[index].count.toString().getFormattedNumber()} ${widget.items[index].unit.name}',
                          style: const TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.items[index].tags
                          .toString()
                          .removeFirstAndLastForTag(),
                      style: const TextStyle(
                        color: Color(0xff667084),
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Цена: ',
                          style: TextStyle(
                            color: Color(0xff72777a),
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          widget.items[index].price.toString().getAmountInSum(),
                          style: const TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GridExpandedWidget extends StatefulWidget {
  const _GridExpandedWidget({
    super.key,
    required this.selections,
    required this.items,
    required this.onTap,
  });

  final List<int> selections;
  final List<WarehouseItemForKassa> items;
  final Function()? onTap;

  @override
  State<_GridExpandedWidget> createState() => _GridExpandedWidgetState();
}

class _GridExpandedWidgetState extends State<_GridExpandedWidget> {
  bool isAddition = true;

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1 / 1.2,
      ),
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            model.tempAdditionController.clear();
            var newPrice = 0.0;

            await showModal(
              context,
              [
                StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    WidgetStateProperty.all<Color?>(
                                  isAddition ? Colors.green : Colors.white,
                                ),
                              ),
                              onPressed: () {
                                isAddition = true;
                                model.tempAdditionController.clear();
                                newPrice = 0.0;
                                widget.items[index].addition = 0; //todo
                                setState(() {});
                              },
                              child: const Text(
                                'Наценка',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                isAddition = false;
                                model.tempAdditionController.clear();
                                newPrice = 0.0;
                                widget.items[index].addition = 0;

                                setState(() {});
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    WidgetStateProperty.all<Color?>(
                                  isAddition ? Colors.white : Colors.green,
                                ),
                              ),
                              child: const Text(
                                'Цена',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        TextFieldWidget(
                          maxLength: isAddition ? 3 : null,
                          hintText: isAddition ? 'Наценка (%)' : 'Цена',
                          textType: TextInputType.number,
                          controller: model.tempAdditionController,
                          onChanged: (p0) {
                            if (p0.isEmpty) {
                              p0 = '0';
                            } else {
                              if (isAddition) {
                                newPrice = widget.items[index].price +
                                    double.parse(p0) /
                                        100 *
                                        widget.items[index].price;
                              } else {
                                newPrice = double.parse(p0.removeWhitespace());
                              }
                            }
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text(
                              'Цена: ',
                              style: TextStyle(
                                color: Color(0xff72777a),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.items[index].price
                                  .toString()
                                  .getAmountInSum(),
                              style: const TextStyle(
                                color: Color(0xff34c85a),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              'Наценка: ',
                              style: TextStyle(
                                color: Color(0xff72777a),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              isAddition
                                  ? (model.tempAdditionController.text.isEmpty
                                      ? '0%'
                                      : '${model.tempAdditionController.text}%')
                                  : '${widget.items[index].addition}%',
                              style: const TextStyle(
                                color: Color(0xff34c85a),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              'Новая цена: ',
                              style: TextStyle(
                                color: Color(0xff72777a),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              newPrice.toString().getAmountInSum(),
                              // (widget.items[index].price *
                              //         widget.items[index].count)
                              //     .toString()
                              //     .getAmountInSum(),
                              style: const TextStyle(
                                color: Color(0xff34c85a),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                MainButtonWidget(
                  isLoading: false,
                  text: 'OK',
                  method: () {
                    if (isAddition) {
                      widget.items[index].addition =
                          double.parse(model.tempAdditionController.text);
                    } else {
                      widget.items[index].addition = 0.0;
                    }
                    widget.items[index].price = newPrice;
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 40),
              ],
              padding: 20,
            );
          },
          onDoubleTap: () {},
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff262629),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: getW(100),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.asset(
                          // 'assets/images/notification/bo-15.png',
                          'assets/images/temp.png',

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: _CustomCheckBox(
                        selections: widget.selections,
                        value:
                            widget.selections.contains(widget.items[index].id),
                        onTap: () {
                          setState(() {
                            if (widget.selections
                                .contains(widget.items[index].id)) {
                              widget.selections.remove(widget.items[index].id);
                            } else {
                              widget.selections.add(widget.items[index].id);
                            }
                          });
                        },
                      ),
                      // child: IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     Icons.more_vert,
                      //     color: Colors.black87,
                      //   ),
                      // ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.items[index].name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${widget.items[index].count.toString().getFormattedNumber()} ${widget.items[index].unit.name}',
                            style: const TextStyle(
                              color: Color(0xff34c85a),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.items[index].tags
                            .toString()
                            .removeFirstAndLastForTag(),
                        style: const TextStyle(
                          color: Color(0xff667084),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Text(
                            'Цена:',
                            style: TextStyle(
                              color: Color(0xff72777a),
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            widget.items[index].price
                                .toString()
                                .getAmountInSum(),
                            style: const TextStyle(
                              color: Color(0xff34c85a),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Text(
                            'Итог:',
                            style: TextStyle(
                              color: Color(0xff72777a),
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            (widget.items[index].price *
                                    widget.items[index].count)
                                .toString()
                                .getAmountInSum(),
                            style: const TextStyle(
                              color: Color(0xff34c85a),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Text(
                            'Наценка:',
                            style: TextStyle(
                              color: Color(0xff72777a),
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '${widget.items[index].addition} %',
                            style: const TextStyle(
                              color: Color(0xff34c85a),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CustomCheckBox extends StatelessWidget {
  const _CustomCheckBox({
    super.key,
    required this.selections,
    required this.value,
    required this.onTap,
  });

  final List<int> selections;
  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.green,
        side: const BorderSide(
          color: Colors.green,
          width: 3,
        ),
        overlayColor: WidgetStateProperty.all(Colors.green),
        // fillColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        value: value,
        // onChanged: (value) {
        // print('object');
        // onTap;
        // setState(() {
        //   if (widget.selections.contains(widget.index)) {
        //     widget.selections.remove(widget.index);
        //   } else {
        //     widget.selections.add(widget.index);
        //   }
        // });
        // },
        onChanged: (value) {
          onTap();
        },
      );
}

// class _ListWidget extends StatefulWidget {
//   const _ListWidget({
//     super.key,
//     required this.selections,
//   });

//   final List<int> selections;

//   @override
//   State<_ListWidget> createState() => _ListWidgetState();
// }

// class _ListWidgetState extends State<_ListWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemCount: 20,
//       separatorBuilder: (context, index) {
//         return const SizedBox(height: 10);
//       },
//       itemBuilder: (context, index) {
//         return Row(
//           children: [
//             // Checkbox(
//             //   value: widget.selections.contains(index),
//             //   onChanged: (value) {
//             //     setState(() {
//             //       if (widget.selections.contains(index)) {
//             //         widget.selections.remove(index);
//             //       } else {
//             //         widget.selections.add(index);
//             //       }
//             //     });
//             //   },
//             // ),
//             // const SizedBox(width: 10),
//             ClipOval(
//               child: Image.asset(
//                 // 'assets/images/notification/bo-10.png',
//                 'assets/images/temp.png',
//                 fit: BoxFit.cover,
//                 height: getW(44),
//                 width: getW(44),
//               ),
//             ),
//             const SizedBox(width: 10),
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Iphone',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       '13 pro max 256 gb',
//                       style: TextStyle(
//                         color: Color(0xff667084),
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Цена:',
//                       style: TextStyle(
//                         color: Color(0xff72777a),
//                         fontSize: 13,
//                       ),
//                     ),
//                     Text(
//                       '15 000 000',
//                       style: TextStyle(
//                         color: Color(0xff34c85a),
//                         fontSize: 13,
//                       ),
//                     ),
//                     Text(
//                       ' sum',
//                       style: TextStyle(
//                         color: Color(0xff34c85a),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const Spacer(),
//             const Text(
//               'x2',
//               style: TextStyle(
//                 color: Color(0xff34c85a),
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(width: 10),

//             _CustomCheckBox(
//               selections: widget.selections,
//               value: widget.selections.contains(index),
//               onTap: () {
//                 setState(() {
//                   if (widget.selections.contains(index)) {
//                     widget.selections.remove(index);
//                   } else {
//                     widget.selections.add(index);
//                   }
//                 });
//               },
//             ),
//             const SizedBox(width: 10),
//           ],
//         );
//       },
//     );
//   }
// }

// class _GridWidget extends StatefulWidget {
//   const _GridWidget({
//     super.key,
//     required this.selections,
//   });

//   final List<int> selections;

//   @override
//   State<_GridWidget> createState() => _GridWidgetState();
// }

// class _GridWidgetState extends State<_GridWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: 20,
//       itemBuilder: (BuildContext context, int index) {
//         return DecoratedBox(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: const Color(0xff262629),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     height: getW(100),
//                     width: double.infinity,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                       ),
//                       child: Image.asset(
//                         // 'assets/images/notification/bo-3.png',
//                         'assets/images/temp.png',

//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 0,
//                     top: 0,
//                     child: IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.more_vert,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Iphone',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       '13 pro max 256 gb',
//                       style: TextStyle(
//                         color: Color(0xff667084),
//                         fontSize: 14,
//                       ),
//                     ),
//                     Text(
//                       '34шт',
//                       style: TextStyle(
//                         color: Color(0xff34c85a),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class _GridExpandedWidget extends StatefulWidget {
//   const _GridExpandedWidget({
//     super.key,
//     required this.selections,
//   });

//   final List<int> selections;

//   @override
//   State<_GridExpandedWidget> createState() => _GridExpandedWidgetState();
// }

// class _GridExpandedWidgetState extends State<_GridExpandedWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//         childAspectRatio: 1 / 1.2,
//       ),
//       itemCount: 20,
//       itemBuilder: (BuildContext context, int index) {
//         return DecoratedBox(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: const Color(0xff262629),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     height: getW(100),
//                     width: double.infinity,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                       ),
//                       child: Image.asset(
//                         // 'assets/images/notification/bo-15.png',
//                         'assets/images/temp.png',

//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 0,
//                     top: 0,
//                     child: IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.more_vert,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'Iphone',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Spacer(),
//                         Text(
//                           '34шт',
//                           style: TextStyle(
//                             color: Color(0xff34c85a),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       '13 pro max 256 gb',
//                       style: TextStyle(
//                         color: Color(0xff667084),
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Row(
//                       children: [
//                         Text(
//                           'Цена:',
//                           style: TextStyle(
//                             color: Color(0xff72777a),
//                             fontSize: 13,
//                           ),
//                         ),
//                         Text(
//                           '15 000 000',
//                           style: TextStyle(
//                             color: Color(0xff34c85a),
//                             fontSize: 13,
//                           ),
//                         ),
//                         Text(
//                           ' sum',
//                           style: TextStyle(
//                             color: Color(0xff34c85a),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 2),
//                     Row(
//                       children: [
//                         Text(
//                           'Итог:',
//                           style: TextStyle(
//                             color: Color(0xff72777a),
//                             fontSize: 13,
//                           ),
//                         ),
//                         Text(
//                           '510,000,000',
//                           style: TextStyle(
//                             color: Color(0xff34c85a),
//                             fontSize: 13,
//                           ),
//                         ),
//                         Text(
//                           ' sum',
//                           style: TextStyle(
//                             color: Color(0xff34c85a),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 2),
//                     Row(
//                       children: [
//                         Text(
//                           'Наценка:',
//                           style: TextStyle(
//                             color: Color(0xff72777a),
//                             fontSize: 13,
//                           ),
//                         ),
//                         Text(
//                           '+30%',
//                           style: TextStyle(
//                             color: Color(0xff34c85a),
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class _CustomCheckBox extends StatelessWidget {
//   const _CustomCheckBox({
//     super.key,
//     required this.selections,
//     required this.value,
//     required this.onTap,
//   });

//   final List<int> selections;
//   final bool value;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) => Checkbox(
//         checkColor: Colors.white,
//         activeColor: Colors.green,
//         side: const BorderSide(
//           color: Colors.green,
//           width: 3,
//         ),
//         overlayColor: WidgetStateProperty.all(Colors.green),
//         // fillColor: WidgetStateProperty.all(Colors.white),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(6),
//         ),
//         value: value,
//         // onChanged: (value) {
//         // print('object');
//         // onTap;
//         // setState(() {
//         //   if (widget.selections.contains(widget.index)) {
//         //     widget.selections.remove(widget.index);
//         //   } else {
//         //     widget.selections.add(widget.index);
//         //   }
//         // });
//         // },
//         onChanged: (value) {
//           onTap();
//         },
//       );
// }
