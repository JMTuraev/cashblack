import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/medium_title_widget.dart';
import 'client_notification_info_view.dart';

class ClientNotificationsView extends StatelessWidget {
  const ClientNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(child: MediumTitleWidget(text: 'Уведомления')),
              Expanded(
                child: ListView.separated(
                  itemCount: 0,
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Biznes egasi tomonidan notification'),
                      subtitle: Text('14:34 20.11.2022 '),
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => ClientNotificationInfoView(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
