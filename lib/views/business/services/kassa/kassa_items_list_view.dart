import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../size_config.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../domain/models/services/warehouse_item_for_kassa.dart';
import '../../../../string_extensions.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/show_modal.dart';

class KassaItemsListView extends StatefulWidget {
  const KassaItemsListView({
    super.key,
  });

  @override
  State<KassaItemsListView> createState() => _KassaItemsListViewState();
}

class _KassaItemsListViewState extends State<KassaItemsListView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // context.read<SkladViewModel>().tempItemsForSale.clear();
    context.read<SkladViewModel>().tempTotalSum = 0;
    for (final element in context.read<SkladViewModel>().tempItemsForSale) {
      context.read<SkladViewModel>().tempTotalSum += element.price;
    }
  }

  int counter = 1;

  List<bool> isShow = [true, false, false];
  List<int> selections = [];

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
          IconButton(
            onPressed: () {
              setState(() {
                if (isShow[0]) {
                  isShow = [false, true, false];
                } else if (isShow[1]) {
                  // isShow = [false, false, true]; //todo qara
                  isShow = [true, false, false];
                } else if (isShow[2]) {
                  isShow = [true, false, false];
                }
              });
            },
            icon: const Icon(Icons.filter),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: isShow[0] == true
                  ? _ListWidget(
                      selections: selections,
                      items: model.tempItems,
                    )
                  : isShow[1] == true
                      ? _GridWidget(
                          selections: selections,
                          items: model.tempItems,
                        )
                      : _GridExpandedWidget(
                          selections: selections,
                          items: model.tempItems,
                        ),
            ),
            const SizedBox(height: 20),
            MainButtonWidget(
              text: 'Добавить',
              method: () async {
                model.tempItemsForSale.clear();
                for (final element in selections) {
                  final a = model.tempItems
                      .where(
                        (e) => e.id == element,
                      )
                      .first;
                  model.tempItemsForSale.add(a);
                }
                await showModal(context, [
                  const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Товары добавлено',
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
                      model.tempTotalSum = 0;
                      for (final element in model.tempItemsForSale) {
                        model.tempTotalSum += element.price;
                      }
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    },
                  ),
                  const SizedBox(height: 40),
                ]);
              },
              isLoading: false,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ListWidget extends StatefulWidget {
  const _ListWidget({
    super.key,
    required this.selections,
    required this.items,
  });

  final List<int> selections;
  final List<WarehouseItemForKassa> items;

  @override
  State<_ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<_ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (context, index) {
        return Row(
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
                      widget.items[index].totalPrice
                          .toString()
                          .getAmountInSum(),
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
            // const Text(
            //   'x2',
            //   style: TextStyle(
            //     color: Color(0xff34c85a),
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const SizedBox(width: 10),

            _CustomCheckBox(
              selections: widget.selections,
              value: widget.selections.contains(index),
              onTap: () {
                // setState(() {
                //   if (widget.selections.contains(index)) {
                //     widget.selections.remove(index);
                //   } else {
                //     widget.selections.add(index);
                //   }
                // });
                setState(() {
                  if (widget.selections.contains(index)) {
                    widget.selections.remove(widget.items[index].id);
                  } else {
                    widget.selections.add(widget.items[index].id);
                  }
                });
              },
            ),
            const SizedBox(width: 10),
          ],
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
                      value: widget.selections.contains(index),
                      onTap: () {
                        // setState(() {
                        //   if (widget.selections.contains(index)) {
                        //     widget.selections.remove(index);
                        //   } else {
                        //     widget.selections.add(index);
                        //   }
                        // });
                        setState(() {
                          if (widget.selections.contains(index)) {
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
                    Text(
                      widget.items[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
                    // Text(
                    //   widget.items[index].unit.title,
                    //   style: const TextStyle(
                    //     color: Color(0xff34c85a),
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
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
                          widget.items[index].totalPrice
                              .toString()
                              .getAmountInSum(),
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
  });

  final List<int> selections;
  final List<WarehouseItemForKassa> items;

  @override
  State<_GridExpandedWidget> createState() => _GridExpandedWidgetState();
}

class _GridExpandedWidgetState extends State<_GridExpandedWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1 / 1.2,
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
                      value: widget.selections.contains(index),
                      onTap: () {
                        // setState(() {
                        //   if (widget.selections.contains(index)) {
                        //     widget.selections.remove(index);
                        //   } else {
                        //     widget.selections.add(index);
                        //   }
                        // });
                        setState(() {
                          if (widget.selections.contains(index)) {
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
                          widget.items[index].unit.title,
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
                          widget.items[index].totalPrice
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
                          widget.items[index].totalPrice
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
