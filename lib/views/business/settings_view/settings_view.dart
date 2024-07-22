import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/owner/business_company.dart';
import '../../../domain/models/owner/business_profile.dart';
import '../../../size_config.dart';
import '../../../string_extensions.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_notifications_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../view_models/business/business_statistics_view_model.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../select_type_view/select_type_view.dart';
import 'companies_list_view.dart';
import 'create_worker_view.dart';
import 'edit_company_view.dart';
import 'edit_name_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

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

  Future<void> getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (pickedFile != null) {
      await context
          .read<BusinessSettingsViewModel>()
          .uploadCompanyAvatar(File(pickedFile.path))
          .then((value) {
        if (value) {
          context.read<BusinessDashboardViewModel>().getBusinessCompany();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<BusinessSettingsViewModel>().businessProfile;
    // var isBusiness = user!.groups.first.name == 'Biznes';
    // var balans = context.watch<BusinessHomeViewModel>().balance;

    // List<Worker> workersList = [];

    final allWorkers = context
        .read<BusinessSettingsViewModel>()
        .workers
        .where((element) => element.id != user!.id)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        // bottom: ThemeDetails.appBarDivider,
        actions: [
          IconButton(
            onPressed: () async {
              context.read<BusinessDashboardViewModel>().maxCashback = 0;
              await context.read<BusinessViewModel>().logout().then(
                (value) {
                  context
                      .read<BusinessStatisticsViewModel>()
                      .cashbackAndWithdraws
                      .clear();
                  context
                      .read<BusinessStatisticsViewModel>()
                      .mergedList
                      .clear();
                  context.read<BusinessStatisticsViewModel>().clients.clear();

                  context.read<BusinessSettingsViewModel>().workers.clear();

                  context.read<BusinessDashboardViewModel>().clearData();

                  return Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (context) => const SelectTypeView(),
                    ),
                    (route) => false,
                  );
                },
              );
            },
            icon: SvgPicture.asset(
              'assets/svg/logout.svg',
              height: getH(24),
              width: getW(24),
            ),
          ),
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
                  context.watch<BusinessDashboardViewModel>().isGettingCompany
                      ? const CupertinoActivityIndicator()
                      : (context.read<BusinessDashboardViewModel>().hasCompany
                          ? _BrandCardWidget(
                              onTap: getFromGallery,
                              isBusiness: true,
                              company: context
                                  .read<BusinessDashboardViewModel>()
                                  .businessCompany!,
                            )
                          : const Text('Создайте компанию')),
                ],
              ),
              // ;
              //     } else {
              //       return const SizedBox();
              //     }
              //   },
              // ),
              const SizedBox(height: 15),
              //TODO apple
              context.watch<BusinessSettingsViewModel>().isLoading
                  ? const SizedBox()
                  : context
                              .read<BusinessSettingsViewModel>()
                              .businessProfile!
                              .status ==
                          1
                      ? (Column(
                          children: [
                            _SubscriptionCardWidget(
                              profile: context
                                  .read<BusinessSettingsViewModel>()
                                  .businessProfile!,
                            ),
                            SizedBox(height: getH(15)),
                          ],
                        ))
                      : const SizedBox(),
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
                        (context
                                    .read<BusinessDashboardViewModel>()
                                    .hasCompany &&
                                context
                                    .read<BusinessDashboardViewModel>()
                                    .hasShops)
                            ? GestureDetector(
                                child:
                                    SvgPicture.asset('assets/svg/user-add.svg'),
                                onTap: () {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const CreateWorkerView(),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(),
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
                                          allWorkers[index]
                                              .phone
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
                      : ((context
                                  .read<BusinessDashboardViewModel>()
                                  .hasCompany &&
                              context
                                  .read<BusinessDashboardViewModel>()
                                  .hasShops)
                          ? const Center(child: Text('У вас нет сотрудников'))
                          : const Center(
                              child: Text(
                                'Создайте компанию и магазин чтобы добавить сотрудников',
                                textAlign: TextAlign.center,
                              ),
                            ))
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
    super.key,
    required this.company,
    required this.onTap,
    required this.isBusiness,
  });

  final BusinessCompany company;
  final bool isBusiness;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {},
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => CompaniesListView(
              shops:
                  context.read<BusinessDashboardViewModel>().businessShopsAll ??
                      [],
            ),
          ),
        );
      },
      child: _BorderContainerWidget(
        child: Row(
          children: [
            // GestureDetector(
            //   onTap: onTap,
            //   onDoubleTap: () {},
            //   child: ClipRRect(
            //     borderRadius: const BorderRadius.all(
            //       Radius.circular(20),
            //     ),
            //     child: SizedBox(
            //       width: getW(60),
            //       height: getH(60),
            //       child: context.watch<BusinessSettingsViewModel>().isUploading
            //           ? const CupertinoActivityIndicator()
            //           : CachedNetworkImage(
            //               fit: BoxFit.cover,
            //               imageUrl: company.logo ?? '',
            //               errorWidget: (context, url, error) => const Icon(
            //                 Icons.home_repair_service_rounded,
            //                 size: 40,
            //               ),
            //             ),
            //     ),
            //   ),
            // ),
            // SizedBox(width: getW(18)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SimpleTextWidget(
                    title: company.name,
                  ),
                  SizedBox(height: getH(4)),
                  Text(
                    company.address,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(width: getW(10)),
            IconButton(
              color: Colors.white,
              hoverColor: Colors.transparent,
              enableFeedback: false,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => CompaniesListView(
                      shops: context
                              .read<BusinessDashboardViewModel>()
                              .businessShopsAll ??
                          [],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.info_outline),
            ),
            SizedBox(width: getW(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isBusiness
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => EditCompanyView(
                                company: company,
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/svg/edit.svg',
                          height: getH(24),
                          width: getW(24),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionCardWidget extends StatelessWidget {
  const _SubscriptionCardWidget({
    super.key,
    required this.profile,
  });

  final BusinessProfile profile;

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
                    title: 'Баланс',
                  ),
                  const SizedBox(width: 10),
                  Text(
                    context.watch<BusinessSettingsViewModel>().isLoading
                        ? ''
                        : profile.balance.getAmountInSum(),
                    style: const TextStyle(
                      color: Color.fromRGBO(103, 206, 103, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Row(
                children: [
                  const _SimpleTextWidget(
                    title: 'Абонентская плата',
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${NumberFormat.simpleCurrency(
                      name: '',
                      locale: 'ru_RU',
                      decimalDigits: 0,
                    ).format(
                      double.parse(
                        context
                            .read<BusinessNotificationsViewModel>()
                            .prices
                            .where(
                              (element) =>
                                  element.type == 'subscript' &&
                                  element.month == 1,
                            )
                            .first
                            .price,
                      ),
                    )}сум',
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
                    //todo active/deactive locense
                    Helpers.subsctibedChecker(profile.licence)
                        ? 'Активен'
                        : 'Не оплачен',
                    style: const TextStyle(
                      color: Color.fromRGBO(103, 206, 103, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              //todo active/deactive license
              Helpers.subsctibedChecker(profile.licence)
                  ? Row(
                      children: [
                        const _SimpleTextWidget(
                          title: 'Последный платеж',
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Helpers.subsctibedChecker(profile.licence)
                              ? profile.licence.first.startAt.getLocaleDate()
                              : 'Не оплачен',
                          style: const TextStyle(
                            color: Color.fromRGBO(103, 206, 103, 1),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 6),
              //todo active/deactive license
              Helpers.subsctibedChecker(profile.licence)
                  ? Row(
                      children: [
                        const _SimpleTextWidget(
                          title: 'Следующий платеж',
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Helpers.subsctibedChecker(profile.licence)
                              ? profile.licence.first.endAt.getLocaleDate()
                              : 'Не оплачен',
                          style: const TextStyle(
                            color: Color.fromRGBO(103, 206, 103, 1),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileCardWidget extends StatelessWidget {
  const _ProfileCardWidget({
    super.key,
    required this.user,
  });

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
                // '998${user?.phone}'.phoneFormatter(),
                '${user?.phone}'.phoneFormatter(),
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
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => EditNameView(
                      user: user!,
                    ),
                  ),
                );
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
    super.key,
    required this.title,
  });

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
  const _BorderContainerWidget({super.key, required this.child});

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
