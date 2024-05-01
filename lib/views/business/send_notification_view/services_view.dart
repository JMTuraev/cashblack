// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../size_config.dart';
import '../services/store/store_categories_view.dart';
import '../services/task/tasks_view.dart';
import 'posts_view.dart';
import 'task_item_widget.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  List<dynamic> notifications = ['asd', 'asd', 'asd'];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Виджеты',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color.fromRGBO(25, 25, 25, 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _IconWidget(
                            svg: 'assets/svg/service-post.svg',
                            title: 'Посты',
                            color: const Color.fromRGBO(48, 42, 54, 1),
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => const PostsView(),
                                ),
                              );
                            },
                          ),
                          const _IconWidget(
                            svg: 'assets/svg/service-chat.svg',
                            title: 'Чат',
                            color: Color.fromRGBO(40, 30, 29, 1),
                            onTap: null,
                          ),
                          const _IconWidget(
                            svg: 'assets/svg/service-schedule.svg',
                            title: 'Табель',
                            color: Color.fromRGBO(45, 37, 24, 1),
                            onTap: null,
                            // onTap: () {
                            //   Navigator.of(context).push(
                            //     CupertinoPageRoute(
                            //       builder: (context) => const TabelView(),
                            //     ),
                            //   );
                            // },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _IconWidget(
                            svg: 'assets/svg/service-store.svg',
                            title: 'Склад',
                            color: const Color.fromRGBO(30, 37, 30, 1),
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const StoreCategoriesView(),
                                ),
                              );
                            },
                            // onTap: null,
                          ),
                          const _IconWidget(
                            svg: 'assets/svg/service-shop.svg',
                            title: 'Продажа',
                            color: Color.fromRGBO(53, 30, 38, 1),
                            onTap: null,
                          ),
                          const _IconWidget(
                            svg: 'assets/svg/service-calculator.svg',
                            title: 'Касса',
                            color: Color.fromRGBO(23, 36, 53, 1),
                            onTap: null,
                            // onTap: () {
                            //   Navigator.of(context).push(
                            //     CupertinoPageRoute(
                            //       builder: (context) => const KassaView(),
                            //     ),
                            //   );
                            // },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const _IconWidget(
                            svg: 'assets/svg/service-add.svg',
                            title: 'Создать',
                            color: Color.fromRGBO(48, 42, 54, 1),
                            onTap: null,
                            // onTap: () {
                            //   Navigator.of(context).push(
                            //     CupertinoPageRoute(
                            //       builder: (context) => const StaffView(),
                            //     ),
                            //   );
                            // },
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 6,
                              right: 6,
                            ),
                            padding: const EdgeInsets.all(18),
                            child: const SizedBox(
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 6,
                              right: 6,
                            ),
                            padding: const EdgeInsets.all(18),
                            child: const SizedBox(
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            1 == 1
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: getH(270),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Color.fromRGBO(25, 25, 25, 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 10,
                          ),
                          child: Text(
                            'Список заданий',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            return TaskItemWidget(
                              onEditPressed: () {},
                            );
                          },
                        ),
                        // const SizedBox(height: 10),
                        const Spacer(),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => TasksView(),
                                ),
                              );
                            },
                            child: const Text(
                              'Показать все',
                              style: TextStyle(
                                color: Color(0xff6cd768),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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

class _IconWidget extends StatelessWidget {
  const _IconWidget({
    super.key,
    required this.svg,
    required this.title,
    required this.color,
    required this.onTap,
  });
  final String svg;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 6,
              right: 6,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: onTap == null ? Colors.black26 : color,
                  ),
                  child: SvgPicture.asset(
                    svg,
                    height: 30,
                    width: 30,
                    color: onTap == null ? Colors.white24 : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: onTap == null ? Colors.white24 : null,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          onTap == null
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(103, 206, 103, 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Скоро',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
