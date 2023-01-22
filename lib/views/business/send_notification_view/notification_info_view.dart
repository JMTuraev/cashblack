// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/sent_notification.dart';
import '../../../theme/theme_details.dart';
import '../../../utils/constants.dart';
import '../../../widgets/medium_title_widget.dart';

class NotificationInfoView extends StatelessWidget {
  const NotificationInfoView({
    Key? key,
    required this.sentNotification,
  }) : super(key: key);

  final SentNotification sentNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sentNotification.shop.name),
        bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    sentNotification.title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  // height: 200,
                  height: MediaQuery.of(context).size.width / 1.5,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    // height: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    imageUrl: Constants.media + sentNotification.image,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  sentNotification.content,
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
