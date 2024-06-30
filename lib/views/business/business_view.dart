import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import '../../utils/helpers.dart';
import '../../view_models/business/business_dashboard_view_model.dart';
import '../../view_models/business/business_notifications_view_model.dart';
import '../../view_models/business/business_payment_view_model.dart';
import '../../view_models/business/business_settings_view_model.dart';
import '../../view_models/business/business_statistics_view_model.dart';
import '../../view_models/business/business_view_model.dart';
import '../../widgets/logo_animated_widget.dart';
import 'business_dashboard_view/business_dashboard_view.dart';
import 'scanner_view/barcode_scanner_view.dart';
import 'scanner_view/freezed_view.dart';
import 'scanner_view/subscription_view.dart';
import 'send_notification_view/services_view.dart';
import 'settings_view/settings_view.dart';
import 'statistics_view/statistics_view.dart';

class BusinessView extends StatefulWidget {
  BusinessView({super.key});

  bool isSeller = false;

  @override
  State<BusinessView> createState() => _BusinessViewState();
}

class _BusinessViewState extends State<BusinessView>
    with WidgetsBindingObserver {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    //todo auto check
    timer = Timer.periodic(
      const Duration(seconds: 15),
      (Timer t) => context.read<BusinessSettingsViewModel>().getOwnerProfile(),
    );

    // checkIsSeller() == true ? print('yes') : print('no');
    context.read<BusinessSettingsViewModel>().getOwnerProfile(); // profil
    context.read<BusinessNotificationsViewModel>().getPrices(); // balansi
    context
        .read<BusinessPaymentViewModel>()
        .getBonusPrices(); //abonent to'lovlar

    context
        .read<BusinessDashboardViewModel>()
        .getBusinessCompany()
        .then((value) {
      if (context.read<BusinessDashboardViewModel>().hasCompany) {
        context
            .read<BusinessViewModel>()
            .getCategories(); // firma tuzishda kategoriya
        context
            .read<BusinessDashboardViewModel>()
            .getBusinessShops()
            .then((value) {
          if (context.read<BusinessDashboardViewModel>().hasShops &&
              context
                  .read<BusinessDashboardViewModel>()
                  .businessShops!
                  .isNotEmpty) {
//
            context.read<BusinessDashboardViewModel>().getWeeklyStatistics(
                  context
                      .read<BusinessDashboardViewModel>()
                      .businessShops!
                      .first
                      .id,
                );
//

            context
                .read<BusinessSettingsViewModel>()
                .getWorkers(); // shop yoki magazin bo'lmasa call qilmasin, xatosi bor

            context.read<BusinessStatisticsViewModel>().getStats(); //stat
            context
                .read<BusinessStatisticsViewModel>()
                .getClients(); //clientlar
          }
        });
      }
    }); //xato agar bo'lmasa

    WidgetsBinding.instance.addObserver(this);
  }

  // Future<bool> checkIsSeller() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var res = await prefs.getBool('isSeller')!;
  //   return res;
  //   // return widget.isSeller;
  // }

  @override
  void dispose() {
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        // Navigator.pop(context);
        break;
      case AppLifecycleState.resumed:
        context.read<BusinessSettingsViewModel>().getOwnerProfile();
      case AppLifecycleState.paused:
        // Navigator.pop(context);
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final currentIndex = context.watch<BusinessViewModel>().currentIndex;

    const iconSize = 34.0;

    final items = <SvgPicture>[
      SvgPicture.asset(
        'assets/svg/home-2.svg',
        color: Colors.white,
        height: currentIndex == 0 ? iconSize : null,
        width: currentIndex == 0 ? iconSize : null,
      ),
      SvgPicture.asset(
        'assets/svg/chart.svg',
        color: Colors.white,
        height: currentIndex == 1 ? iconSize : null,
        width: currentIndex == 1 ? iconSize : null,
      ),
      SvgPicture.asset(
        'assets/svg/scan-barcode.svg',
        color: Colors.white,
        height: currentIndex == 2 ? iconSize : null,
        width: currentIndex == 2 ? iconSize : null,
      ),
      SvgPicture.asset(
        'assets/svg/element-4.svg',
        color: Colors.white,
        height: currentIndex == 3 ? iconSize : null,
        width: currentIndex == 3 ? iconSize : null,
      ),
      SvgPicture.asset(
        'assets/svg/setting-2.svg',
        color: Colors.white,
        height: currentIndex == 4 ? iconSize : null,
        width: currentIndex == 4 ? iconSize : null,
      ),
    ];

    final itemsForWorkers = <SvgPicture>[
      // SvgPicture.asset(
      //   'assets/svg/home-2.svg',
      //   color: Colors.white,
      //   height: currentIndex == 0 ? iconSize : null,
      //   width: currentIndex == 0 ? iconSize : null,
      // ),
      // SvgPicture.asset(
      //   'assets/svg/chart.svg',
      //   color: Colors.white,
      //   height: currentIndex == 1 ? iconSize : null,
      //   width: currentIndex == 1 ? iconSize : null,
      // ),
      SvgPicture.asset(
        'assets/svg/scan-barcode.svg',
        color: Colors.white,
        height: currentIndex == 0 ? iconSize : null,
        width: currentIndex == 0 ? iconSize : null,
      ),
      SvgPicture.asset(
        'assets/svg/setting-2.svg',
        color: Colors.white,
        height: currentIndex == 1 ? iconSize : null,
        width: currentIndex == 1 ? iconSize : null,
      ),
    ];

    return context.watch<BusinessSettingsViewModel>().isLoading
        ? const Scaffold(
            body: LogoAnimatedWidget(size: 1.5),
          )
        : Scaffold(
            // extendBody: true,
            bottomNavigationBar: CurvedNavigationBar(
              buttonBackgroundColor: const Color.fromRGBO(103, 206, 103, 1),
              backgroundColor: Colors.transparent,
              color: const Color.fromRGBO(28, 28, 29, 1),
              index: currentIndex,
              items: context
                          .read<BusinessSettingsViewModel>()
                          .businessProfile!
                          .type ==
                      'owner'
                  ? items
                  : itemsForWorkers,
              onTap: (index) {
                context.read<BusinessViewModel>().onChange(index);
              },
            ),
            body: context
                        .read<BusinessSettingsViewModel>()
                        .businessProfile!
                        .type ==
                    'owner'
                ? IndexedStack(
                    index: currentIndex,
                    children: [
                      const BusinessDashboardView(),
                      const StatisticsView(),
                      currentIndex == 2 &&
                              Helpers.subsctibedChecker(
                                context
                                    .read<BusinessSettingsViewModel>()
                                    .businessProfile!
                                    .licence,
                              )
                          ? BarcodeScannerView(
                              shopId: 1,
                            )
                          : const SubscriptionView(
                              isBusiness: true,
                              subscribtionPrice: '1',
                              shopId: 1,
                            ),

                      const ServicesView(),
                      const SettingsView(),

                      // currentIndex == 2 && 1 == 1
                      //     ? BarcodeScannerView(
                      //         shopId: 1,
                      //       )
                      //     : SubscriptionView(
                      //         isBusiness: true,
                      //         subscribtionPrice: '1000',
                      //         shopId: 1,
                      //       ),
                      // const ServicesView(),
                      // const SettingsView(),
                    ],
                  )
                : IndexedStack(
                    index: currentIndex,
                    children: [
                      // const BusinessDashboardView(),
                      // const StatisticsView(),
                      currentIndex == 0 && 1 == 1
                          ? 2 == 2
                              ? const FreezedView()
                              : BarcodeScannerView(
                                  shopId: 1,
                                )
                          : const SubscriptionView(
                              isBusiness: true,
                              subscribtionPrice: '2000',
                              shopId: 1,
                            ),
                      const SettingsView(),
                    ],
                  ),
          );
  }
}
