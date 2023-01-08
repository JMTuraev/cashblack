import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/main_button_widget.dart';
import '../business/auth/business_login_view/business_login_view.dart';
import '../client/auth/client_login_view/client_login_view.dart';

class SelectTypeView extends StatelessWidget {
  const SelectTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Stack(
                children: [
                  MainButtonWidget(
                    text: 'Бизнес',
                    method: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const BusinessLoginView(),
                        ),
                        // CupertinoPageRoute(
                        //   builder: (context) => const BusinessHomeView(),
                        // ),
                      );
                    },
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Tooltip(
                      message: 'Biznes create qilish uchun',
                      verticalOffset: 48,
                      height: 24,
                      child: const Icon(
                        Icons.help_outline,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  MainButtonWidget(
                    text: 'Клиент',
                    method: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const ClientLoginView(),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Tooltip(
                      message: 'Klient create qilish uchun',
                      verticalOffset: 48,
                      height: 24,
                      child: const Icon(
                        Icons.help_outline,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              // TODO help buttonlar kerak
              const Spacer(),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    // enableDrag: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView(
                          children: [
                            SizedBox(height: 6),
                            Text(
                              'Public offer',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.Lorem ipsum dolor sit amet, vide omnesque scaevola his in, nam et quas dicit solet, mei minimum repudiandae an. Stet illum fabulas ad eos, et esse dignissim per. Partiendo principes referrentur et est, posse omnesque iudicabit est ut, per in principes delicatissimi. Quaerendum intellegebat qui ei, duo at odio error aliquam. Offendit appellantur disputationi vim ut, ad dolorem detraxit eos, at vim debet laoreet.',
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'Публичная оферта',
                ),
              ),
              // SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
