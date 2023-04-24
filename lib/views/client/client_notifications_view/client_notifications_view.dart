import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/received_notification.dart';
import '../../../extensions.dart';
import '../../../size_config.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/client_home_view_model.dart';
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
  late Future notifs;

  @override
  void initState() {
    super.initState();
    notifs = context.read<ClientHomeViewModel>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
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
              FutureBuilder(
                future: notifs,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var list = snapshot.data as List<ReceivedNotification>;
                    var notifications = list
                        .where(
                            (element) => DateTime.parse(element.date).isAfter(
                                  DateTime.now().subtract(
                                    const Duration(
                                      days: 2,
                                    ),
                                  ),
                                ))
                        .toList();
                    if (notifications.length > 0) {
                      return Expanded(
                        child: EasyRefresh(
                          header: const MaterialHeader(),
                          onRefresh: () {
                            setState(() {
                              notifs = context
                                  .read<ClientHomeViewModel>()
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
                                          ClientNotificationInfoView(
                                        receivedNotification:
                                            notifications[index],
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
                                        child: Image.asset(
                                          Helpers.getLocalImage(
                                            notifications[index].title,
                                          ),
                                          fit: BoxFit.fitHeight,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
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
                                              Text(
                                                notifications[index].name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                notifications[index].category,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
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
                              return ListTile(
                                title: Text(
                                  notifications[index].title,
                                ),
                                subtitle: Text(
                                  notifications[index].content,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: getH(10));
                            },
                          ),
                        ),
                      );
                    } else {
                      return EasyRefresh(
                        header: const MaterialHeader(),
                        onRefresh: () {
                          setState(() {
                            notifs = context
                                .read<ClientHomeViewModel>()
                                .getNotifications();
                          });
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            const Center(child: EmptyWidget()),
                          ],
                        ),
                      );
                    }
                  } else
                    return const LogoAnimatedWidget(size: 1.5);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
