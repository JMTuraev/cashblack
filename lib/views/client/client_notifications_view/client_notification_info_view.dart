import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/received_notification.dart';
import '../../../extensions.dart';
import '../../../utils/constants.dart';
import '../../../widgets/medium_title_widget.dart';

class ClientNotificationInfoView extends StatelessWidget {
  const ClientNotificationInfoView({
    Key? key,
    required this.receivedNotification,
  }) : super(key: key);

  final ReceivedNotification receivedNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receivedNotification.name),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    receivedNotification.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.width / 1.5,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: Constants.media + receivedNotification.image,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  receivedNotification.date.getLocaleDateTime(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Text(
                  receivedNotification.content,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
