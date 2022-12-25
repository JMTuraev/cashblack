import 'package:flutter/material.dart';

import '../../../widgets/helpers.dart';
import '../../../widgets/hero_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';

class PaymentsHistoryView extends StatelessWidget {
  const PaymentsHistoryView({super.key});

  @override
  Widget build(BuildContext context) => ScreenWrapper(
        child: Column(
          children: [
            const HeroTitleWidget(text: 'History'),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 13,
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  title: const Text(
                    '50 000',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: const Text('12 ноября 2022 12:25'),
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(Helpers.customSnackBar('To`lov info'));
                  },
                );
              },
            ),
          ],
        ),
      );
}
