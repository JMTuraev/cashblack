import 'package:flutter/material.dart';

import '../../../widgets/medium_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';

class ClientNotificationInfoView extends StatelessWidget {
  const ClientNotificationInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        children: [
          Center(child: MediumTitleWidget(text: 'Xabar sarlavhasi')),
          SizedBox(height: 20),
          Placeholder(
            fallbackWidth: double.infinity,
            fallbackHeight: 200,
          ),
          SizedBox(height: 10),
          Text(
            'Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.',
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
