import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../../string_extensions.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/client/client_dashboard_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';
import 'client_notification_info_view.dart';

class ClientNotificationsView extends StatefulWidget {
  const ClientNotificationsView({super.key});

  @override
  State<ClientNotificationsView> createState() =>
      _ClientNotificationsViewState();
}

class _ClientNotificationsViewState extends State<ClientNotificationsView> {
  @override
  Widget build(BuildContext context) {
    final notifications = context
        .read<ClientDashboardViewModel>()
        .notifications
        .notifications
        .reversed
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Уведомления'),
          // bottom: ThemeDetails.appBarDivider,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: EasyRefresh(
                  header: const MaterialHeader(),
                  onRefresh: () {
                    setState(() {
                      context
                          .read<ClientDashboardViewModel>()
                          .getNotifications();
                    });
                  },
                  child: context
                          .watch<ClientDashboardViewModel>()
                          .isLoadingNotifications
                      ? const LogoAnimatedWidget(size: 1.5)
                      : notifications.isNotEmpty
                          ? ListView.separated(
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            ClientNotificationInfoView(
                                          receivedNotification:
                                              notifications[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 20,
                                      right: 20,
                                      top: 20,
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Color.fromRGBO(44, 45, 47, 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: notifications[index]
                                                        .shop
                                                        ?.logo ??
                                                    '',
                                                fit: BoxFit.cover,
                                                height: getH(50),
                                                width: getH(50),
                                                errorWidget: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) =>
                                                    Container(
                                                  height: getH(50),
                                                  width: getH(50),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white24,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      notifications[index]
                                                              .shop
                                                              ?.name
                                                              .substring(
                                                                0,
                                                                1,
                                                              ) ??
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
                                                          .shop
                                                          ?.name ??
                                                      '',
                                                  style: const TextStyle(
                                                      // color: Color.fromRGBO(
                                                      //   103,
                                                      //   206,
                                                      //   103,
                                                      //   1,
                                                      // ),
                                                      // fontSize: 16,
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
                                                    // fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notifications[index].text,
                                              maxLines: 2,
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              notifications[index]
                                                  .updatedAt
                                                  .getLocaleDateTime(
                                                    addingHours: 5,
                                                  ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                        ClipRRect(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          // borderRadius: const BorderRadius.only(
                                          //   topLeft: Radius.circular(20),
                                          //   bottomLeft: Radius.circular(20),
                                          // ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          child: notifications[index].image !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: notifications[index]
                                                          .image ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Image.asset(
                                                      Helpers.getLocalImage(
                                                        // 'assets/images/notification/ak-${index + 1}.png',
                                                        notifications[index]
                                                            .title,
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
                                        // const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  context
                                                      .read<
                                                          ClientDashboardViewModel>()
                                                      .likeNotification(
                                                        notifications[index].id,
                                                        1,
                                                      )
                                                      .then((value) {
                                                    context
                                                        .read<
                                                            ClientDashboardViewModel>()
                                                        .getNotifications();
                                                  });
                                                });
                                              },
                                              icon: context
                                                              .watch<
                                                                  ClientDashboardViewModel>()
                                                              .notifications
                                                              .notifications[
                                                                  index]
                                                              .like ==
                                                          0 ||
                                                      context
                                                              .watch<
                                                                  ClientDashboardViewModel>()
                                                              .notifications
                                                              .notifications[
                                                                  index]
                                                              .like ==
                                                          false
                                                  ? const Icon(
                                                      Icons
                                                          .favorite_border_rounded,
                                                      color: Color.fromRGBO(
                                                        164,
                                                        164,
                                                        164,
                                                        1,
                                                      ),
                                                      size: 28,
                                                    )
                                                  : const Icon(
                                                      Icons.favorite_rounded,
                                                      color: Color.fromRGBO(
                                                        164,
                                                        164,
                                                        164,
                                                        1,
                                                      ),
                                                      size: 28,
                                                    ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              notifications[index]
                                                  .likeCount
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                  164,
                                                  164,
                                                  164,
                                                  1,
                                                ),
                                                fontSize: 18,
                                              ),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.remove_red_eye_rounded,
                                              color: Color.fromRGBO(
                                                164,
                                                164,
                                                164,
                                                1,
                                              ),
                                              size: 26,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              notifications[index]
                                                  .showedCount
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                  164,
                                                  164,
                                                  164,
                                                  1,
                                                ),
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
                            )
                          : const Center(child: EmptyWidget()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
