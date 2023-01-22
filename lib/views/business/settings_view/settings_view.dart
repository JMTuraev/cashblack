import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:cashblack/extensions.dart';

import '../../../domain/models/balance.dart';
import '../../../domain/models/shop.dart';
import '../../../domain/models/user.dart';
import '../../../domain/models/worker.dart';
import '../../../theme/theme_details.dart';
import '../../../utils/constants.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/helpers.dart';
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
    // User user = context.watch<BusinessHomeViewModel>().user;
    // Shop shop = user.shops.last;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        bottom: ThemeDetails.appBarDivider,
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<BusinessHomeViewModel>().logout();
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => const SelectTypeView(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              FutureBuilder(
                future: context.watch<BusinessHomeViewModel>().getProfile(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var user = snapshot.data as User;
                    return Column(
                      children: [
                        _ProfileCardWidget(
                          user: user,
                        ),
                        const SizedBox(height: 15),
                        _BrandCardWidget(
                          shop: user.shops.last,
                        ),
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
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
              Expanded(
                child: FutureBuilder(
                  future: context.watch<BusinessHomeViewModel>().getWorkers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Worker> workers = snapshot.data as List<Worker>;
                      return ListView.separated(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: workers.length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 1,
                          );
                        },
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              '${workers[index].firstName} ${workers[index].lastName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              workers[index].userName.phoneFormatter(),
                            ),
                            // trailing: IconButton(
                            //   //TODO delete
                            //   onPressed: () {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         Helpers.customSnackBar(
                            //             'Sotrudnikni o`chirish'));
                            //   },
                            //   icon: const Icon(
                            //     CupertinoIcons.clear_circled,
                            //   ),
                            // ),
                            trailing: CupertinoSwitch(
                              activeColor: Colors.grey[100],
                              thumbColor: Colors.black,
                              trackColor: Colors.grey,
                              // value: false,
                              value: true,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            // onTap: () {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       Helpers.customSnackBar(
                            //           'Ichida info bo`lish-bo`lmasligini aniqlash kerak'));
                            // },
                          );
                        },
                      );
                    } else {
                      return Text('');
                    }
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

class _BrandCardWidget extends StatelessWidget {
  const _BrandCardWidget({
    Key? key,
    required this.shop,
  }) : super(key: key);

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    var imageUrl = Constants.media + shop.image!;
    return _BorderContainerWidget(
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  errorWidget: (context, url, error) => Icon(Icons.clear),
                ),
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
                      Text('${shop.cashback} %'),
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
              //todo deliberately
              method: () {
                // Navigator.of(context).push(
                //   CupertinoPageRoute(
                //     builder: (context) => const EditStoreView(),
                //   ),
                // );
              },
              text: 'Изменить',
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
                      title: 'Имя не указано',
                    )
                  : _SimpleTextWidget(
                      title: '${user!.firstName} ${user!.lastName}',
                    ),
              const SizedBox(height: 10),
              Text(user!.userName.phoneFormatter()),
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
