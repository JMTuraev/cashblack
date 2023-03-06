import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/sent_notification.dart';
import '../../../extensions.dart';
import '../../../size_config.dart';
import '../../../utils/constants.dart';
import '../../../view_models/send_notification_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';
import 'notification_info_view.dart';
import 'send_notification_view.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  late Future sentFuture;
  @override
  void initState() {
    sentFuture = context.read<SendNotificationViewModel>().getNotifications();
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
          'Сервисы',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              FutureBuilder(
                future: sentFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var notifications = snapshot.data as List<SentNotification>;
                    if (notifications.length > 0) {
                      return Expanded(
                        child: EasyRefresh(
                          header: const MaterialHeader(),
                          onRefresh: () {
                            setState(() {
                              sentFuture = context
                                  .read<SendNotificationViewModel>()
                                  .getNotifications();
                            });
                          },
                          child: ListView.separated(
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          NotificationInfoView(
                                        sentNotification: notifications[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Color.fromRGBO(28, 28, 29, 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fitHeight,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          imageUrl: Constants.media +
                                              notifications[index].image,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    notifications[index]
                                                        .shop
                                                        .name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  if (notifications[index]
                                                          .status ==
                                                      1)
                                                    const Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      color: Colors.white,
                                                    )
                                                  else if (notifications[index]
                                                          .status ==
                                                      3)
                                                    Column(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .check_circle_outline_sharp,
                                                          color: DateTime.parse(
                                                            notifications[index]
                                                                .date,
                                                          ).isAfter(
                                                            DateTime.now()
                                                                .subtract(
                                                              const Duration(
                                                                days: 2,
                                                              ),
                                                            ),
                                                          )
                                                              ? Colors.white
                                                              // : Colors.red,
                                                              : Colors.white,
                                                        ),
                                                      ],
                                                    )
                                                  else
                                                    const Icon(
                                                      Icons
                                                          .remove_circle_outline_sharp,
                                                      // color: Colors.red,
                                                    ),
                                                  const SizedBox(width: 6),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Text(
                                                  notifications[index].title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                notifications[index]
                                                    .date
                                                    .getLocaleDateTime(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                child: notifications[index]
                                                            .status ==
                                                        1
                                                    ? const Text(
                                                        'Проверяется',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    75,
                                                                    132,
                                                                    231,
                                                                    1)),
                                                      )
                                                    : notifications[index]
                                                                .status ==
                                                            3
                                                        ? DateTime.parse(
                                                            notifications[index]
                                                                .date,
                                                          ).isAfter(
                                                            DateTime.now()
                                                                .subtract(
                                                              const Duration(
                                                                days: 2,
                                                              ),
                                                            ),
                                                          )
                                                            ? Row(
                                                                children: [
                                                                  const Text(
                                                                    'Видимость: ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    DateTime.parse(
                                                                          notifications[index]
                                                                              .date,
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
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : const Text(
                                                                'Истекло',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
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
                                        ),
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
                      );
                    } else
                      return const Center(child: EmptyWidget());
                  } else
                    return const Center(
                      child: LogoAnimatedWidget(
                        size: 1.5,
                      ),
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
