import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/received_notification.dart';
import '../../../domain/models/sent_notification.dart';
import '../../../theme/theme_details.dart';
import '../../../utils/constants.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../view_models/send_notification_view_model.dart';
import '../../../widgets/main_button_widget.dart';

import 'package:cashblack/extensions.dart';

import '../../business/send_notification_view/notification_info_view.dart';
import 'client_notification_info_view.dart';

class ClientNotificationsView extends StatelessWidget {
  const ClientNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Уведомления'),
          bottom: ThemeDetails.appBarDivider,
        ),
        body: Container(
          child: Column(
            children: [
              FutureBuilder(
                future: context.watch<ClientHomeViewModel>().getNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var notifications =
                        snapshot.data as List<ReceivedNotification>;
                    return Expanded(
                      child: ListView.separated(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      ClientNotificationInfoView(
                                    receivedNotification: notifications[index],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Container(
                                // height: MediaQuery.of(context).size.width / 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      borderRadius: BorderRadius.only(
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
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        // color: Colors.red,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              notifications[index].name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              notifications[index].title,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            // SizedBox(height: 4),
                                            // Text(
                                            //   notifications[index]
                                            //       .date
                                            //       .getLocaleDateTime(),
                                            //   maxLines: 2,
                                            //   overflow: TextOverflow.ellipsis,
                                            // ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
                          return const Divider(height: 1);
                        },
                      ),
                    );
                  } else
                    return Text('no');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
