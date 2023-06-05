import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

import '../../../domain/models/sent_notification.dart';
import '../../../string_extensions.dart';
import '../../../size_config.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/send_notification_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';
import 'notification_info_view.dart';
import 'send_notification_view.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  // List<SentNotification> notifications = [];
  List<dynamic> notifications = ['asd', 'asd', 'asd'];
  @override
  void initState() {
    // sentFuture = context.read<SendNotificationViewModel>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Отправка уведомлений',
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const SendNotificationView(),
                ),
              );
            },
            icon: SvgPicture.asset(
              'assets/svg/send.svg',
              width: getW(24),
              height: getH(24),
            ),
          ),
        ],
        title: const Text(
          'Посты',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Отправленные уведомления',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: EasyRefresh(
                header: const MaterialHeader(),
                onRefresh: () {
                  setState(() {
                    // sentFuture = context
                    //     .read<SendNotificationViewModel>()
                    //     .getNotifications();
                  });
                },
                child: ListView.separated(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   CupertinoPageRoute(
                        //     builder: (context) => NotificationInfoView(
                        //       sentNotification: notifications[index],
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color.fromRGBO(44, 45, 47, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/images/notification/ak-3.png',
                                    fit: BoxFit.cover,
                                    height: getH(50),
                                    width: getH(50),
                                  ),
                                ),
                                SizedBox(width: getW(16)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dood',
                                      style: TextStyle(
                                        color: Color.fromRGBO(103, 206, 103, 1),
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      'Dood',
                                      style: TextStyle(
                                        color: Color.fromRGBO(147, 147, 147, 1),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an.',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // const SizedBox(height: 4),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //     right: 4,
                                //   ),
                                //   child: Text(
                                //     notifications[index].content,
                                //     maxLines: 2,
                                //     overflow:
                                //         TextOverflow.ellipsis,
                                //     style: const TextStyle(
                                //       fontSize: 18,
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(height: 4),
                                Text(
                                  '2023-06-06'.getLocaleDateTime(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Container(
                                  // child: notifications[index].status == 1
                                  child: 1 == 1
                                      ? const Text(
                                          'Проверяется',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  75, 132, 231, 1)),
                                        )
                                      // : notifications[index].status == 3
                                      : 1 == 3
                                          ? DateTime.parse(
                                              '2023-06-06',
                                            ).isAfter(
                                              DateTime.now().subtract(
                                                const Duration(
                                                  days: 2,
                                                ),
                                              ),
                                            )
                                              ? Row(
                                                  children: [
                                                    const Text(
                                                      'Видимость: ',
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateTime.parse(
                                                            '2023-06-06',
                                                          )
                                                              .add(
                                                                const Duration(
                                                                  days: 2,
                                                                ),
                                                              )
                                                              .difference(
                                                                DateTime.now(),
                                                              )
                                                              .inHours
                                                              .toString() +
                                                          ' часов',
                                                      style: const TextStyle(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const Text(
                                                  'Истекло',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                )
                                          : const Text(
                                              'Отменен',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                )
                              ],
                            ),
                            ClipRRect(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              child: Image.asset(
                                Helpers.getLocalImage(
                                  'assets/images/notification/ak-${index + 1}.png',
                                ),
                                // height: MediaQuery.of(context).size.width / 4,
                                // width: MediaQuery.of(context).size.width / 3,
                              ),
                              //   CachedNetworkImage(
                              //     fit: BoxFit.fitHeight,
                              //     height: MediaQuery.of(context)
                              //             .size
                              //             .width /
                              //         4,
                              //     width: MediaQuery.of(context)
                              //             .size
                              //             .width /
                              //         3,
                              //     imageUrl: Constants.media +
                              //         notifications[index].image,
                              //   ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  Icons.favorite_border_rounded,
                                  color: Color.fromRGBO(164, 164, 164, 1),
                                  size: 28,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '21',
                                  style: TextStyle(
                                    color: Color.fromRGBO(164, 164, 164, 1),
                                    fontSize: 18,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.remove_red_eye_rounded,
                                  color: Color.fromRGBO(164, 164, 164, 1),
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    color: Color.fromRGBO(164, 164, 164, 1),
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 14),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: getH(10));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
