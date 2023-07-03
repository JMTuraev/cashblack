import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/owner/owner_notification.dart';
import '../../../domain/models/sent_notification.dart';
import '../../../string_extensions.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';

class NotificationInfoView extends StatelessWidget {
  const NotificationInfoView({
    Key? key,
    required this.sentNotification,
  }) : super(key: key);

  final OwnerNotification sentNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sentNotification.title),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: Text(
                //     sentNotification.title,
                //     textAlign: TextAlign.center,
                //     style: const TextStyle(
                //       fontSize: 24,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.width / 1.5,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Image.asset(
                      Helpers.getLocalImage(
                        sentNotification.title,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      sentNotification.updatedAt.getLocaleDateTime(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      sentNotification.status == 1
                          ? 'Проверяется'
                          : (sentNotification.status == 2 ? 'Отменен' : ''),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  sentNotification.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
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
