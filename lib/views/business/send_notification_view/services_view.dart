import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/sent_notification.dart';
import '../../../extensions.dart';
import '../../../theme/theme_details.dart';
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
  late final Future sentFuture;
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
            icon: const Icon(
              Icons.send_rounded,
            ),
          ),
        ],
        title: const Text(
          'Сервисы',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: ThemeDetails.appBarDivider,
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
                        child: ListView.separated(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => NotificationInfoView(
                                      sentNotification: notifications[index],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fitWidth,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Spacer(),
                                                if (notifications[index]
                                                        .status ==
                                                    1)
                                                  const Icon(
                                                    Icons.watch_later,
                                                    color: Color.fromRGBO(
                                                        100, 181, 246, 1),
                                                  )
                                                else if (notifications[index]
                                                        .status ==
                                                    3)
                                                  const Icon(
                                                    Icons.check_circle_sharp,
                                                    color: Color.fromRGBO(
                                                        129, 199, 132, 1),
                                                  )
                                                else
                                                  const Icon(Icons.clear),
                                                const SizedBox(width: 6),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              notifications[index].title,
                                              style: const TextStyle(
                                                fontSize: 18,
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
                            return const Divider(height: 1);
                          },
                        ),
                      );
                    } else
                      return Center(child: EmptyWidget());
                  } else
                    return const Center(
                        child: LogoAnimatedWidget(
                      size: 1.5,
                    ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
