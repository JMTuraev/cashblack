import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../domain/models/sent_notification.dart';
import '../../../../../string_extensions.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/helpers.dart';
import '../../../../size_config.dart';
import '../../../../widgets/show_modal.dart';
import '../../../../widgets/text_field_widget.dart';
import '../../../../widgets/text_field_with_label_widget.dart';
import '../../send_notification_view/services_view.dart';
import '../../send_notification_view/task_item_widget.dart';

class TasksView extends StatefulWidget {
  TasksView({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задачи'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getW(100),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 9,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 20);
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              // 'assets/images/notification/bo-10.png',
                              'assets/images/email.png',
                              fit: BoxFit.cover,
                              width: getW(80),
                              height: getW(80),
                            ),
                          ),
                          const Text(
                            'Dood',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: getW(26),
                          width: getW(26),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: Colors.green,
                            border: Border.all(
                              width: 1,
                              color: Colors.black87,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '99',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: getW(20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isShow = !isShow;
                            });
                          },
                          child: Container(
                            height: getW(26),
                            width: getW(26),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: Colors.green,
                              border: Border.all(
                                width: 1,
                                color: Colors.black87,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            isShow
                ? Stack(
                    children: [
                      Positioned(
                        child: Column(
                          children: [
                            SizedBox(height: getH(10)),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x4f091e42),
                                    blurRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                  BoxShadow(
                                    color: Color(0x3f091e42),
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                                color: const Color(0xff262629),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      hintText: 'Заголовок задании',
                                      controller: textEditingController,
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      height: 40,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 10,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(width: 10);
                                        },
                                        itemBuilder: (context, index) {
                                          return ClipOval(
                                            child: Image.asset(
                                              'assets/images/notification/ak-3.png',
                                              fit: BoxFit.cover,
                                              height: 40,
                                              width: 40,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const Positioned(
                        top: 0,
                        left: 20,
                        child: Text(
                          'Новая задания',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            const Text(
              'Список задании',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return TaskItemWidget(
                    image: index.isEven ? '' : null,
                    onEditPressed: () {
                      showModal(context, [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Изменить задания',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(48),
                                color: const Color(0xfff04437),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7,
                              ),
                              child: const Text(
                                'Удалить',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFieldWithLabelWidget(
                          hintText: 'Заголовок задания',
                          controller: textEditingController,
                        ),
                        const SizedBox(height: 10),
                        TextFieldWithLabelWidget(
                          hintText: 'Описания',
                          controller: textEditingController,
                          maxLines: 3,
                          maxLength: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Участники',
                          style: TextStyle(
                            color: Color(0xff72777a),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: getW(40),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 31,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 10);
                            },
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return SvgPicture.asset(
                                  'assets/svg/broken_add.svg',
                                  height: getW(40),
                                  width: getW(40),
                                  color: Colors.white,
                                );
                              } else {
                                return ClipOval(
                                  child: Image.asset(
                                    'assets/images/notification/bo-25.png',
                                    height: getW(40),
                                    width: getW(40),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFieldWithLabelWidget(
                          hintText: 'Срок',
                          controller: textEditingController,
                        ),
                        const SizedBox(height: 40),
                      ]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
