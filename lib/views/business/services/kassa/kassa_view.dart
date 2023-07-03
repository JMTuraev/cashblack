// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../size_config.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/text_field_widget.dart';
import '../../../../widgets/text_field_with_label_widget.dart';

class KassaView extends StatefulWidget {
  const KassaView({
    Key? key,
  }) : super(key: key);

  @override
  State<KassaView> createState() => _KassaViewState();
}

class _KassaViewState extends State<KassaView> {
  List<bool> isShow = [true, false, false];
  List<int> selections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Касса'),
        // leadingWidth: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter)),
          IconButton(
            onPressed: () {
              setState(() {
                if (isShow[0]) {
                  isShow = [false, true, false];
                } else if (isShow[1]) {
                  isShow = [false, false, true];
                } else if (isShow[2]) {
                  isShow = [true, false, false];
                }
              });
            },
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
                    flex: 1,
                    child: Stack(
                      children: [
                        TextFieldWithLabelWidget(
                          hintText: 'К-во',
                          radius: 10,
                          isCenter: true,
                          maxLength: 4,
                          showLength: false,
                        ),
                        Positioned.fill(
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
                        Positioned.fill(
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
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 2,
                    child: TextFieldWithLabelWidget(
                      hintText: 'Штрих код',
                      radius: 10,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    height: getW(56),
                    width: getW(56),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(90),
                      ),
                      color: Colors.green,
                    ),
                    child: const Icon(Icons.clear),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isShow[0] == true
                  ? _ListWidget(
                      selections: selections,
                    )
                  : isShow[1] == true
                      ? _GridWidget(
                          selections: selections,
                        )
                      : _GridExpandedWidget(
                          selections: selections,
                        ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x72000000),
                    blurRadius: 18,
                    offset: Offset(0, 0),
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
                          Row(
                            children: [
                              const Text(
                                "Скидка: ",
                                style: TextStyle(
                                  color: Color(0xff72777a),
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                "3%",
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
                                "Итого: ",
                                style: TextStyle(
                                  color: Color(0xff72777a),
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                "15 000 000",
                                style: TextStyle(
                                  color: Color(0xff34c85a),
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                "sum",
                                style: TextStyle(
                                  color: Color(0xff34c85a),
                                  fontSize: 12,
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
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child:
                              TextFieldWithLabelWidget(hintText: 'Покупател')),
                      const SizedBox(width: 10),
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.green,
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: const Center(
                            child: Text(
                          'JM',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MainButtonWidget(text: 'Оплатить', method: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ListWidget extends StatefulWidget {
  const _ListWidget({
    Key? key,
    required this.selections,
  }) : super(key: key);

  final List<int> selections;

  @override
  State<_ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<_ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,
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
                'assets/images/email.png',
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
                    const Text(
                      'Iphone',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '13 pro max 256 gb',
                      style: TextStyle(
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
                    const Text(
                      '15 000 000',
                      style: TextStyle(
                        color: Color(0xff34c85a),
                        fontSize: 13,
                      ),
                    ),
                    const Text(
                      ' sum',
                      style: TextStyle(
                        color: Color(0xff34c85a),
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            const Text(
              'x2',
              style: TextStyle(
                color: Color(0xff34c85a),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10),

            _CustomCheckBox(
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
  });

  final List<int> selections;

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
                        // 'assets/images/notification/bo-3.png',
                        'assets/images/email.png',

                        fit: BoxFit.cover,
                      ),
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Iphone',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      '13 pro max 256 gb',
                      style: TextStyle(
                        color: Color(0xff667084),
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      '34шт',
                      style: TextStyle(
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
    super.key,
    required this.selections,
  });

  final List<int> selections;

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
                        'assets/images/email.png',

                        fit: BoxFit.cover,
                      ),
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Iphone',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          '34шт',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '13 pro max 256 gb',
                      style: TextStyle(
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
                        const Text(
                          '15 000 000',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 13,
                          ),
                        ),
                        const Text(
                          ' sum',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 12,
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
                        const Text(
                          '510,000,000',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 13,
                          ),
                        ),
                        const Text(
                          ' sum',
                          style: TextStyle(
                            color: Color(0xff34c85a),
                            fontSize: 12,
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
                        const Text(
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
        overlayColor: MaterialStateProperty.all(Colors.green),
        fillColor: MaterialStateProperty.all(Colors.green),
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
