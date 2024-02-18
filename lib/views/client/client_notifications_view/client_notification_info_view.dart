import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/owner/owner_notification.dart';
import '../../../string_extensions.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/client/client_dashboard_view_model.dart';

class ClientNotificationInfoView extends StatefulWidget {
  const ClientNotificationInfoView({
    Key? key,
    required this.receivedNotification,
  }) : super(key: key);

  final OwnerNotification receivedNotification;

  @override
  State<ClientNotificationInfoView> createState() =>
      _ClientNotificationInfoViewState();
}

class _ClientNotificationInfoViewState
    extends State<ClientNotificationInfoView> {
  @override
  void initState() {
    super.initState();

    context
        .read<ClientDashboardViewModel>()
        .readNotification(widget.receivedNotification.id);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.receivedNotification.like);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receivedNotification.title.split('-').first),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                Container(
                  height: MediaQuery.of(context).size.width / 1.5,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: widget.receivedNotification.image != null
                        ? CachedNetworkImage(
                            imageUrl: widget.receivedNotification.image ?? '',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                Helpers.getLocalImage(
                                  widget.receivedNotification.title,
                                ),
                              );
                            },
                          )
                        : Image.asset(
                            Helpers.getLocalImage(
                              widget.receivedNotification.title,
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          context
                              .read<ClientDashboardViewModel>()
                              .likeNotification(
                                widget.receivedNotification.id,
                                1,
                              );
                        });
                      },
                      icon: widget.receivedNotification.like == 0 ||
                              widget.receivedNotification.like == false
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
                      widget.receivedNotification.likeCount.toString(),
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
                    const SizedBox(width: 4),
                    Text(
                      widget.receivedNotification.showedCount.toString(),
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
                      widget.receivedNotification.updatedAt
                          .getLocaleDateTime(addingHours: 5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      widget.receivedNotification.shop?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.receivedNotification.text,
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
