import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/services/warehouse_item.dart';
import '../../../../../size_config.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';
import '../../../../../widgets/empty_widget.dart';
import '../../../../../widgets/logo_animated_widget.dart';
import 'create_warehouse_item_view.dart';

class WarehouseItemsListView extends StatefulWidget {
  const WarehouseItemsListView({
    super.key,
  });

  @override
  State<WarehouseItemsListView> createState() => _WarehouseItemsListViewState();
}

class _WarehouseItemsListViewState extends State<WarehouseItemsListView> {
  List<bool> isShow = [true, false, false];
  bool isSecondView = true;
  List<int> selections = [];

  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Товары'),
        centerTitle: false,
        // leadingWidth: 0,
        actions: [
          // _CustomCheckBox(
          //   selections: selections,
          //   value: selections.isNotEmpty,
          //   onTap: () {
          //     setState(() {
          //       if (selections.length < 20) {
          //         selections = List.generate(20, (index) => index);
          //       } else {
          //         selections.clear();
          //       }
          //     });
          //   },
          // ),
          // IconButton(
          //   onPressed: () {
          //     showModal(context, [
          //       SizedBox(
          //         width: double.infinity,
          //         child: Column(
          //           children: [
          //             const SizedBox(height: 30),
          //             const Text(
          //               'Наценка',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontSize: 24,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //             const SizedBox(height: 30),
          //             TextFieldWidget(
          //               hintText: 'Наименование',
          //               showLabel: true,
          //               // controller:,
          //               validator: (value) {
          //                 if (value == null || value.isEmpty) {
          //                   return 'Заполните поле';
          //                 }
          //                 return null;
          //               },
          //             ),
          //             const SizedBox(height: 20),
          //             GestureDetector(
          //               onTap: () {},
          //               onDoubleTap: () {
          //                 Navigator.pop(context);
          //               },
          //               child: Container(
          //                 width: double.infinity,
          //                 padding: const EdgeInsets.symmetric(
          //                   horizontal: 30,
          //                   vertical: 15,
          //                 ),
          //                 decoration: const BoxDecoration(
          //                   color: Colors.blueGrey,
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(
          //                       10,
          //                     ),
          //                   ),
          //                 ),
          //                 child: const Text(
          //                   'Отмена',
          //                   textAlign: TextAlign.center,
          //                 ),
          //               ),
          //             ),
          //             const SizedBox(height: 20),
          //             GestureDetector(
          //               onTap: () {},
          //               onDoubleTap: () {
          //                 Navigator.pop(context);
          //               },
          //               child: Container(
          //                 width: double.infinity,
          //                 padding: const EdgeInsets.symmetric(
          //                   horizontal: 30,
          //                   vertical: 15,
          //                 ),
          //                 decoration: const BoxDecoration(
          //                   color: Colors.green,
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(
          //                       10,
          //                     ),
          //                   ),
          //                 ),
          //                 child: const Text(
          //                   'Применять',
          //                   textAlign: TextAlign.center,
          //                 ),
          //               ),
          //             ),
          //             const SizedBox(height: 50),
          //           ],
          //         ),
          //       ),
          //     ]);
          //   },
          //   icon: const Icon(Icons.percent),
          // ),
          IconButton(
            onPressed: () {
              setState(() {
                isSecondView = !isSecondView;
              });
            },
            icon: const Icon(Icons.grid_view_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const CreateWarehouseItemView(),
                ),
              );
            },
            icon: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(90),
                ),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: context.watch<SkladViewModel>().isGettingWarehouseItems
          ? const LogoAnimatedWidget(size: 1.5)
          : Padding(
              padding: const EdgeInsets.all(10),
              child: model.warehouseItems.isEmpty
                  ? const Center(child: EmptyWidget())
                  : Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              // child: isShow[0] == true
                              //     ? _ListWidget(
                              //         selections: selections,
                              //         warehouseItems: model.warehouseItems,
                              //       )
                              //     : isShow[1] == true
                              //         ? _GridWidget(
                              //             selections: selections,
                              //             warehouseItems: model.warehouseItems,
                              //           )
                              //         : _GridExpandedWidget(
                              //             selections: selections,
                              //             warehouseItems: model.warehouseItems,
                              //           ),
                              child: isSecondView
                                  ? _ListWidget(
                                      selections: selections,
                                      warehouseItems: model.warehouseItems,
                                    )
                                  : _GridWidget(
                                      selections: selections,
                                      warehouseItems: model.warehouseItems,
                                    ),
                            ),
                            SizedBox(
                              height: getW(70),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: getW(40),
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 20,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 4);
                                  },
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: index == 0
                                            ? const Color(0xff34c85a)
                                            : const Color(0xff262629),
                                      ),
                                      child: const Text(
                                        '128gb',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: getW(4)),
                              SizedBox(
                                height: getW(40),
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 20,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 4);
                                  },
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: index == 0
                                            ? const Color(0xff34c85a)
                                            : const Color(0xff262629),
                                      ),
                                      child: const Text(
                                        'Iphone',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}

class _ListWidget extends StatefulWidget {
  const _ListWidget({
    required this.selections,
    required this.warehouseItems,
  });

  final List<int> selections;
  final List<WarehouseItem> warehouseItems;

  @override
  State<_ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<_ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.warehouseItems.length,
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
                Text(
                  widget.warehouseItems[index].name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.warehouseItems[index].category.name,
                  style: const TextStyle(
                    color: Color(0xff667084),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            // const Spacer(),
            //  Text(
            //   '34шт',
            //   style: TextStyle(
            //     color: Color(0xff34c85a),
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const SizedBox(width: 10),
          ],
        );
      },
    );
  }
}

class _GridWidget extends StatefulWidget {
  const _GridWidget({
    required this.selections,
    required this.warehouseItems,
  });

  final List<int> selections;
  final List<WarehouseItem> warehouseItems;

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
      itemCount: widget.warehouseItems.length,
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
                  // Positioned(
                  //   left: 0,
                  //   top: 0,
                  //   child: _CustomCheckBox(
                  //     selections: widget.selections,
                  //     value: widget.selections.contains(index),
                  //     onTap: () {
                  //       setState(() {
                  //         if (widget.selections.contains(index)) {
                  //           widget.selections.remove(index);
                  //         } else {
                  //           widget.selections.add(index);
                  //         }
                  //       });
                  //     },
                  //   ),
                  // ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.warehouseItems[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.warehouseItems[index].category.name,
                      style: const TextStyle(
                        color: Color(0xff667084),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.warehouseItems[index].barCode,
                      style: const TextStyle(
                        color: Color(0xff34c85a),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
    required this.selections,
    required this.warehouseItems,
  });

  final List<int> selections;
  final List<WarehouseItem> warehouseItems;

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
      itemCount: 20,
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
                        setState(() {
                          if (widget.selections.contains(index)) {
                            widget.selections.remove(index);
                          } else {
                            widget.selections.add(index);
                          }
                        });
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Iphone',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '34шт',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '13 pro max 256 gb',
                      style: TextStyle(
                        color: Color(0xff667084),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Цена:',
                          style: TextStyle(
                            color: Color(0xff72777a),
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '15 000 000',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          ' sum',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Итог:',
                          style: TextStyle(
                            color: Color(0xff72777a),
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '510,000,000',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          ' sum',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Наценка:',
                          style: TextStyle(
                            color: Color(0xff72777a),
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '+30%',
                          style: TextStyle(
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
        // fillColor: WidgetStateProperty.all(Colors.green),
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
