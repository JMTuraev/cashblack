import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/owner/owner_notification.dart';
import '../../../string_extensions.dart';
import '../../../utils/helpers.dart';

class NotificationInfoView extends StatelessWidget {
  const NotificationInfoView({
    super.key,
    required this.sentNotification,
  });

  final OwnerNotification sentNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sentNotification.title.split('-').first),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: Text(
                //     receivedNotification.title,
                //     textAlign: TextAlign.center,
                //     style: const TextStyle(
                //       fontSize: 24,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 1.5,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: sentNotification.image != null
                        ? CachedNetworkImage(
                            imageUrl: sentNotification.image ?? '',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                Helpers.getLocalImage(
                                  sentNotification.title,
                                ),
                              );
                            },
                          )
                        : Image.asset(
                            Helpers.getLocalImage(
                              sentNotification.title,
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // const SizedBox(width: 10),
                    IconButton(
                      onPressed: null,
                      icon: sentNotification.like == 0 ||
                              sentNotification.like == false
                          ? const Icon(
                              Icons.favorite_border_rounded,
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
                      sentNotification.likeCount.toString(),
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
                    // const SizedBox(width: 14),
                    const Spacer(),
                    const Icon(
                      Icons.remove_red_eye_rounded,
                      color: Color.fromRGBO(164, 164, 164, 1),
                      size: 26,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      sentNotification.showedCount.toString(),
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
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      sentNotification.updatedAt
                          .getLocaleDateTime(addingHours: 5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      sentNotification.shop?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
