import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/balance.dart';
import '../../../domain/models/shop.dart';
import '../../../domain/models/user.dart';
import '../../../domain/models/worker.dart';
import '../../../extensions.dart';
import '../../../theme/theme_details.dart';
import '../../../utils/constants.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/text_button_widget.dart';
import '../../select_type_view/select_type_view.dart';
import 'create_worker_view.dart';
import 'edit_name_view.dart';
import 'edit_store_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late User user;
  late final Future<User> userFuture;
  late final Future<List<Balance>> balanceFuture;
  late final Future<List<Worker>> workersFuture;

  @override
  void initState() {
    user = context.read<BusinessHomeViewModel>().user;
    userFuture = context.read<BusinessHomeViewModel>().getProfile();
    balanceFuture = context.read<BusinessHomeViewModel>().getBalance();
    workersFuture = context.read<BusinessHomeViewModel>().getWorkers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var user = context.watch<BusinessHomeViewModel>().user;
    var isBusiness = user!.groups.first.name == 'Biznes';

    List<Worker> workersList = context.watch<BusinessHomeViewModel>().workers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        bottom: ThemeDetails.appBarDivider,
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<BusinessHomeViewModel>().logout().then(
                    (value) => Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const SelectTypeView(),
                      ),
                      (route) => false,
                    ),
                  );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              FutureBuilder(
                future: userFuture,
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
                          isBusiness: isBusiness,
                          shop: user.shops.last,
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                future: balanceFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var balance = snapshot.data!.first as Balance;
                    return _SubscriptionCardWidget(
                      balance: balance,
                    );
                  } else
                    return const SizedBox();
                },
              ),
              isBusiness
                  ? Row(
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
                    )
                  : const SizedBox(),
              isBusiness
                  ? Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: workersList.length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 1,
                          );
                        },
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              '${workersList[index].firstName} ${workersList[index].lastName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              workersList[index].userName.phoneFormatter(),
                            ),
                            trailing: CupertinoSwitch(
                              activeColor: Colors.grey[100],
                              thumbColor: Colors.black,
                              trackColor: Colors.grey,
                              value: !workersList[index].isFreezed,
                              onChanged: (value) async {
                                await context
                                    .read<BusinessHomeViewModel>()
                                    .switchWorker(
                                      workersList[index].id,
                                      !value,
                                    );
                                print(context
                                    .read<BusinessHomeViewModel>()
                                    .workers
                                    .first
                                    .isFreezed);
                                setState(() {});
                                print('object');
                              },
                            ),
                            contentPadding: const EdgeInsets.all(0),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
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
    required this.isBusiness,
  }) : super(key: key);

  final Shop shop;
  final bool isBusiness;

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
                  errorWidget: (context, url, error) => const Icon(Icons.clear),
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
          isBusiness
              ? Positioned(
                  top: 5,
                  right: 5,
                  child: TextButtonWidget(
                    method: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => EditStoreView(
                            shop: shop,
                          ),
                        ),
                      );
                    },
                    text: 'Изменить',
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class _SubscriptionCardWidget extends StatelessWidget {
  const _SubscriptionCardWidget({
    Key? key,
    required this.balance,
  }) : super(key: key);

  final Balance balance;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _SimpleTextWidget(
                    title: 'Абонентская плата',
                  ),
                  const SizedBox(width: 10),
                  Text(
                    NumberFormat.simpleCurrency(
                          name: '',
                          locale: 'ru_RU',
                          decimalDigits: 0,
                        ).format(double.parse(
                            balance.balanceShop.subscriptionPrice)) +
                        'сум',
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text('Создано в'),
                  const SizedBox(width: 8),
                  Text(balance.balanceShop.createdDate.getLocaleDateTime()),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  // const Text('Следующий платеж'),
                  const Text('Статус'),
                  const SizedBox(width: 8),
                  // Text(balance.balanceShop.createdDate.getLocaleDateTime()),
                  Text(
                    balance.isSubscribedOne ? 'Активен' : 'Не оплачен',
                  ),
                ],
              ),
              const SizedBox(height: 6),
              balance.balanceShop.paymentDate != null
                  ? Row(
                      children: [
                        const Text('Следующий платеж'),
                        const SizedBox(width: 8),
                        Text(balance.balanceShop.paymentDate ?? 'Не оплачен')
                      ],
                    )
                  : const SizedBox(),
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
