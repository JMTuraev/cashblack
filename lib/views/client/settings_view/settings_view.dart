import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../view_models/settings_view_model.dart';
import '../../../widgets/screen_wrapper.dart';
import '../../../widgets/text_button_widget.dart';
import '../../business/settings_view/edit_name_view.dart';
import '../../business/settings_view/payments_history_view.dart';
import '../../select_type_view/select_type_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.read<ClientHomeViewModel>().user;

    return ScreenWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const MediumTitleWidget(text: 'Settings'),
          // const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Column(
                  children: [
                    const Center(
                      child: Text(
                        'Cashback баланс',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '0 UZS',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => PaymentsHistoryView(),
                          ),
                        );
                      },
                      child: Column(
                        children: const [
                          Icon(
                            CupertinoIcons.arrow_right_arrow_left_circle,
                            size: 30,
                          ),
                          Text('История'),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    child: const Icon(Icons.logout),
                    onTap: () async {
                      await context.read<SettingsViewModel>().logout();
                      Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => const SelectTypeView(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          _ProfileCardWidget(
            user: user,
          ),
          const SizedBox(height: 15),
          const Text(
            'Магазины',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          // const _BrandCardWidget(),
          // const SizedBox(height: 10),
          // const _BrandCardWidget(),
        ],
      ),
    );
  }
}

class _BrandCardWidget extends StatelessWidget {
  const _BrandCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Row(
        children: [
          const SizedBox(
            width: 60,
            height: 60,
            child: FlutterLogo(),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SimpleTextWidget(
                title: 'Brand name',
              ),
              const Text('Category name'),
              Row(
                children: const [
                  Icon(
                    CupertinoIcons.money_dollar_circle,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text('0.3'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ProfileCardWidget extends StatelessWidget {
  const _ProfileCardWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user!.firstName.isEmpty && user!.lastName.isEmpty
                  ? const _SimpleTextWidget(
                      title: 'Имя не введено',
                    )
                  : _SimpleTextWidget(
                      title: '${user!.firstName} ${user!.lastName}',
                    ),
              const SizedBox(height: 10),
              Text(user!.userName),
            ],
          ),
          Positioned(
            top: 5,
            right: 5,
            child: TextButtonWidget(
              method: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => EditNameView(
                      user: user!,
                    ),
                  ),
                );
              },
              text: 'Изменить',
            ),
          ),
        ],
      ),
    );
  }
}

class _SimpleTextWidget extends StatelessWidget {
  const _SimpleTextWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _BorderContainerWidget extends StatelessWidget {
  const _BorderContainerWidget({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.white24,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
