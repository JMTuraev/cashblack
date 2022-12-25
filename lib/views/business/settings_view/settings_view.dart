import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/shop.dart';
import '../../../domain/models/user.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../view_models/settings_view_model.dart';
import '../../../widgets/helpers.dart';
import '../../../widgets/screen_wrapper.dart';
import '../../../widgets/text_button_widget.dart';
import '../../select_type_view/select_type_view.dart';
import 'create_worker_view.dart';
import 'edit_name_view.dart';
import 'edit_store_view.dart';
import 'payment_view.dart';
import 'payments_history_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.read<BusinessHomeViewModel>().user;
    Shop shop = user.shops.last;

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
                    const Text(
                      'Ваш баланс',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '1 200 000 UZS',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => const PaymentView(),
                              ),
                            );
                          },
                          child: Column(
                            children: const [
                              Icon(
                                CupertinoIcons.add_circled,
                                size: 30,
                              ),
                              Text('Пополнить'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const PaymentsHistoryView(),
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
                        ),
                      ],
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
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   Helpers.customSnackBar('Logout'),
                      // );
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
          _BrandCardWidget(
            shop: shop,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Text(
                'Сотрудники',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              TextButton(
                child: const Text(
                  'Добавить',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const CreateWorkerView(),
                    ),
                  );
                },
              ),
            ],
          ),
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
                  'Сотрудник Имя Фамилия',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                subtitle: const Text('+998 90 123 45 56'),
                trailing: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          Helpers.customSnackBar('Sotrudnikni o`chirish'));
                    },
                    icon: const Icon(
                      CupertinoIcons.clear_circled,
                    )),
                contentPadding: const EdgeInsets.all(0),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      Helpers.customSnackBar(
                          'Ichida info bo`lish-bo`lmasligini aniqlash kerak'));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BrandCardWidget extends StatelessWidget {
  const _BrandCardWidget({
    Key? key,
    required this.shop,
  }) : super(key: key);

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Stack(
        children: [
          Row(
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
                  _SimpleTextWidget(
                    title: shop.name,
                  ),
                  Text(shop.category.title),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.money_dollar_circle,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text('${shop.cashback} % ${shop.id}'),
                    ],
                  ),
                ],
              )
            ],
          ),
          Positioned(
            top: 5,
            right: 5,
            child: TextButtonWidget(
              method: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const EditStoreView(),
                  ),
                );
              },
              text: 'Edit',
            ),
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
                      title: 'Ism familiya kiritilmagan',
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
              text: 'Edit',
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
