import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/balance.dart';
import '../../../domain/models/balance_shop.dart';
import '../../../domain/models/owner/business_company.dart';
import '../../../domain/models/owner/business_profile.dart';
import '../../../string_extensions.dart';
import '../../../size_config.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../select_type_view/select_type_view.dart';
import 'create_worker_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // late User user;
  // late final Future<User> userFuture;
  // late final Future<List<Balance>> balanceFuture;
  // late final Future<List<Worker>> workersFuture;

  @override
  void initState() {
    // user = context.read<BusinessHomeViewModel>().user;
    // userFuture = context.read<BusinessHomeViewModel>().getProfile();
    // balanceFuture = context.read<BusinessHomeViewModel>().getBalance();
    // workersFuture = context.read<BusinessHomeViewModel>().getWorkers();
    // context.read<BusinessSettingsViewModel>().getOwnerProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var user = context.watch<BusinessHomeViewModel>().user;
    // var isBusiness = user!.groups.first.name == 'Biznes';
    // var balans = context.watch<BusinessHomeViewModel>().balance;

    // List<Worker> workersList = [];

    final allWorkers = context.read<BusinessSettingsViewModel>().workers;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        // bottom: ThemeDetails.appBarDivider,
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<BusinessViewModel>().logout().then(
                    (value) => Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const SelectTypeView(),
                      ),
                      (route) => false,
                    ),
                  );
            },
            icon: SvgPicture.asset(
              'assets/svg/logout.svg',
              height: getH(24),
              width: getW(24),
            ),
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
              // FutureBuilder(
              //   future: userFuture,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       var user = snapshot.data as User;
              //       return
              Column(
                children: [
                  context.watch<BusinessSettingsViewModel>().isLoading
                      ? const CupertinoActivityIndicator()
                      : _ProfileCardWidget(
                          user: context
                              .read<BusinessSettingsViewModel>()
                              .businessProfile,
                        ),
                  const SizedBox(height: 15),
                  context.watch<BusinessDashboardViewModel>().isLoading
                      ? const CupertinoActivityIndicator()
                      : _BrandCardWidget(
                          isBusiness: true,
                          company: context
                              .read<BusinessDashboardViewModel>()
                              .businessCompany!,
                        ),
                ],
              ),
              // ;
              //     } else {
              //       return const SizedBox();
              //     }
              //   },
              // ),
              const SizedBox(height: 15),
              _SubscriptionCardWidget(
                balance: Balance(
                  id: 1,
                  amount: '12121',
                  date: '2023-05-05',
                  balanceShop: BalanceShop(
                    subscriptionPrice: '0',
                    createdDate: '2023-05-06',
                  ),
                  isSubscribedOne: false,
                ),
              ),
              SizedBox(height: getH(20)),
              1 == 1
                  ? Row(
                      children: [
                        const Text(
                          'Сотрудники',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: SvgPicture.asset('assets/svg/user-add.svg'),
                          onTap: () {
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
              SizedBox(height: getH(20)),

              !context.watch<BusinessSettingsViewModel>().isLoading
                  ? allWorkers.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: allWorkers.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: getH(10));
                            },
                            itemBuilder: (context, index) {
                              return _BorderContainerWidget(
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${allWorkers[index].firstName} ${allWorkers[index].lastName}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: getH(4)),
                                        Text(
                                          '998${allWorkers[index].phone}'
                                              .phoneFormatter(),
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                              164,
                                              164,
                                              164,
                                              1,
                                            ),
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: getH(4)),
                                        Text(
                                          allWorkers[index].shop.name,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                              164,
                                              164,
                                              164,
                                              1,
                                            ),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    CupertinoSwitch(
                                      activeColor: const Color.fromRGBO(
                                        103,
                                        206,
                                        103,
                                        1,
                                      ),
                                      thumbColor: Colors.white,
                                      trackColor:
                                          const Color.fromRGBO(57, 57, 61, 1),
                                      value: allWorkers[index].status == 1
                                          ? true
                                          : false,
                                      // value: true,
                                      onChanged: (value) async {
                                        // setState(() {});
                                        await context
                                            .read<BusinessSettingsViewModel>()
                                            .updateSellerStatus(
                                              allWorkers[index].id,
                                              allWorkers[index].status == 1
                                                  ? 0
                                                  : 1,
                                            )
                                            .then((value) {
                                          if (value) {
                                            context
                                                .read<
                                                    BusinessSettingsViewModel>()
                                                .getWorkers();
                                            // Navigator.pop(context);
                                          } else {
                                            print('xato');
                                          }
                                        });
                                        print('object');
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(child: Text('У вас нет сотрудников'))
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
    required this.company,
    required this.isBusiness,
  }) : super(key: key);

  final BusinessCompany company;
  final bool isBusiness;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: SizedBox(
              width: getW(60),
              height: getH(60),
              child: CachedNetworkImage(
                imageUrl: company.logo,
                errorWidget: (context, url, error) => const Icon(
                  Icons.home_repair_service_rounded,
                  size: 40,
                ),
              ),
            ),
          ),
          SizedBox(width: getW(18)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SimpleTextWidget(
                title: company.name,
              ),
              SizedBox(height: getH(4)),
              Text(
                company.inn,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isBusiness
                  ? GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   CupertinoPageRoute(
                        //     builder: (context) => EditStoreView(
                        //       shop: shop,
                        //     ),
                        //   ),
                        // );
                      },
                      child: SvgPicture.asset(
                        'assets/svg/edit.svg',
                        height: getH(24),
                        width: getW(24),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
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
                        ).format(
                          double.parse(
                            balance.balanceShop.subscriptionPrice,
                          ),
                        ) +
                        'сум',
                    style: const TextStyle(
                      color: Color.fromRGBO(103, 206, 103, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 6),
              // Row(
              //   children: [
              //     const Text('Создано в'),
              //     const SizedBox(width: 8),
              //     Text(balance.balanceShop.createdDate.getLocaleDateTime()),
              //   ],
              // ),
              const SizedBox(height: 6),
              Row(
                children: [
                  // const Text('Следующий платеж'),
                  const _SimpleTextWidget(
                    title: 'Статус',
                  ),
                  const SizedBox(width: 8),
                  // Text(balance.balanceShop.createdDate.getLocaleDateTime()),
                  Text(
                    balance.isSubscribedOne ? 'Активен' : 'Не оплачен',
                    style: const TextStyle(
                      color: Color.fromRGBO(103, 206, 103, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              balance.date != null && balance.isSubscribedOne
                  ? Row(
                      children: [
                        const _SimpleTextWidget(
                          title: 'Следующий платеж',
                        ),
                        const SizedBox(width: 8),
                        Text(
                          balance.date != null
                              ? DateTime.parse(balance.date ?? '2023-04-01')
                                  .add(const Duration(days: 30))
                                  .toString()
                                  .getLocaleDate()
                              : 'Не оплачен',
                          style: const TextStyle(
                            color: Color.fromRGBO(103, 206, 103, 1),
                            fontSize: 15,
                          ),
                        )
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

  final BusinessProfile? user;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user == null
                  ? const _SimpleTextWidget(
                      title: 'Имя не указано',
                    )
                  : _SimpleTextWidget(
                      title: '${user?.firstName} ${user?.lastName}',
                    ),
              const SizedBox(height: 10),
              Text(
                '998${user?.phone}'.phoneFormatter(),
                style: const TextStyle(
                  color: Color(0xffa3a3a3),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   CupertinoPageRoute(
                //     builder: (context) => EditNameView(
                //       user: user!,
                //     ),
                //   ),
                // );
              },
              child: SvgPicture.asset(
                'assets/svg/edit.svg',
                height: getH(24),
                width: getW(24),
              ),
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
      padding: EdgeInsets.symmetric(
        horizontal: getW(23),
        vertical: getH(15),
      ),
      decoration: const BoxDecoration(
        // border: Border.all(
        //   width: 1,
        //   color: Colors.white24,
        // ),
        color: Color.fromRGBO(28, 28, 29, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
