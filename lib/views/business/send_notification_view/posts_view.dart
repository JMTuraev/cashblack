import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:provider/provider.dart';

// import 'package:provider/provider.dart';

import '../../../domain/models/owner/owner_notification.dart';
import '../../../size_config.dart';
import '../../../string_extensions.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_notifications_view_model.dart';
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
    context.read<BusinessNotificationsViewModel>().getNotifications();
    super.initState();
  }

  int currentShopIndex = -1;
  List<OwnerNotification> filteredNotifications = [];

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.read<BusinessNotificationsViewModel>().notifations;
    // filteredNotifications = notifications;
    final businessShops =
        context.read<BusinessDashboardViewModel>().businessShops!;
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: getH(10)),
            height: getH(85),
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: businessShops.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemBuilder: (context, index) {
                      final shop = businessShops[index];
                      return GestureDetector(
                        onTap: () {
                          // print(notifications
                          //     .where(
                          //       (element) => element.shop?.id == 12,
                          //     )
                          //     .toList());
                          setState(() {
                            // currentShopIndex =
                            //     currentShopIndex == -1 ? index : -1;
                            if (currentShopIndex != index) {
                              currentShopIndex = index;
                            } else {
                              currentShopIndex = -1;
                            }
                            filteredNotifications = notifications
                                .where(
                                  (element) =>
                                      element.shop?.id ==
                                      businessShops[index].id,
                                )
                                .toList();
                          });
                        },
                        child: Container(
                          height: getH(65),
                          width: getH(65),
                          decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: currentShopIndex == index
                            //       ? const Color(0xff67ce67)
                            //       : Colors.black,
                            //   width: 3,
                            // ),
                            border: currentShopIndex == index
                                ? GradientBoxBorder(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.green.shade500,
                                        Colors.orange.shade500,
                                      ],
                                    ),
                                    width: 3,
                                  )
                                : Border.all(
                                    width: 3,
                                  ),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                // offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: businessShops[index].logo != null
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: businessShops[index].logo!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: Container(
                                    // color: Color(
                                    //   (math.Random().nextDouble() * 0xFFFF11)
                                    //       .toInt(),
                                    // ).withOpacity(1),
                                    color: Colors.black38,
                                    alignment: Alignment.center,
                                    child: Text(
                                      shop.name.substring(0, 1),
                                      style: const TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  // child: Image.asset(
                                  //   'assets/images/notification/ak-1.png',
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // const Text(
          //   'Отправленные уведомления',
          //   style: TextStyle(
          //     fontSize: 22,
          //   ),
          // ),
          // const SizedBox(height: 20),
          Expanded(
            child: EasyRefresh(
              header: const MaterialHeader(),
              onRefresh: () {
                context
                    .read<BusinessNotificationsViewModel>()
                    .getNotifications();

                // setState(() {
                //   context.read<BusinessNotificationsViewModel>();
                // });
              },
              child: context
                      .watch<BusinessNotificationsViewModel>()
                      .isLoadingNotifications
                  ? const LogoAnimatedWidget(size: 1.5)
                  : ListView.separated(
                      itemCount: currentShopIndex == -1
                          ? notifications.length
                          : filteredNotifications.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => NotificationInfoView(
                                  sentNotification: currentShopIndex == -1
                                      ? notifications[index]
                                      : filteredNotifications[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Color.fromRGBO(44, 45, 47, 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        // 'assets/images/notification/ak-3.png',
                                        imageUrl: context
                                                .read<
                                                    BusinessDashboardViewModel>()
                                                .businessCompany
                                                ?.logo ??
                                            '',
                                        fit: BoxFit.cover,
                                        height: getH(50),
                                        width: getH(50),
                                        errorWidget:
                                            (context, error, stackTrace) =>
                                                Container(
                                          height: getH(50),
                                          width: getH(50),
                                          decoration: const BoxDecoration(
                                            color: Colors.white24,
                                          ),
                                          child: Center(
                                            child: Text(
                                              context
                                                      .read<
                                                          BusinessDashboardViewModel>()
                                                      .businessCompany
                                                      ?.name
                                                      .substring(0, 1) ??
                                                  'C',
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: getW(16)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notifications[index]
                                              .title
                                              .split('-')
                                              .first,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                              103,
                                              206,
                                              103,
                                              1,
                                            ),
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          notifications[index]
                                              .updatedAt
                                              .getLocaleDateTime(
                                                addingHours: 5,
                                              ),
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                              147,
                                              147,
                                              147,
                                              1,
                                            ),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notifications[index].text,
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
                                      notifications[index]
                                          .updatedAt
                                          .getLocaleDateTime(addingHours: 5),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      // child: notifications[index].status == 1
                                      child: notifications[index].status ==
                                              'pending'
                                          ? const Text(
                                              'Проверяется',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                  75,
                                                  132,
                                                  231,
                                                  1,
                                                ),
                                              ),
                                            )
                                          // : notifications[index].status == 3
                                          : notifications[index].status ==
                                                  'approved'
                                              ? DateTime.parse(
                                                  notifications[index].endAt,
                                                ).isAfter(
                                                  DateTime.now(),
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
                                                          '${DateTime.parse(
                                                            notifications[index]
                                                                .endAt,
                                                          ).difference(
                                                                DateTime.now(),
                                                              ).inHours} часов',
                                                          style:
                                                              const TextStyle(
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
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                ClipRRect(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  // borderRadius: const BorderRadius.only(
                                  //   topLeft: Radius.circular(20),
                                  //   bottomLeft: Radius.circular(20),
                                  // ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  child: notifications[index].image != null
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              notifications[index].image ?? '',
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) {
                                            return Image.asset(
                                              Helpers.getLocalImage(
                                                // 'assets/images/notification/ak-${index + 1}.png',
                                                notifications[index].title,
                                              ),
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          Helpers.getLocalImage(
                                            // 'assets/images/notification/ak-${index + 1}.png',
                                            notifications[index].title,
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
                                    const SizedBox(width: 10),
                                    const Icon(
                                      Icons.favorite_border_rounded,
                                      color: Color.fromRGBO(164, 164, 164, 1),
                                      size: 28,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      notifications[index].likeCount.toString(),
                                      style: const TextStyle(
                                        color: Color.fromRGBO(164, 164, 164, 1),
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: Color.fromRGBO(164, 164, 164, 1),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      notifications[index]
                                          .showedCount
                                          .toString(),
                                      style: const TextStyle(
                                        color: Color.fromRGBO(164, 164, 164, 1),
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                  ],
                                ),
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
    );
  }
}
