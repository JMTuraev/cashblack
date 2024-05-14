import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import '../../view_models/business/business_notifications_view_model.dart';
import '../../view_models/business/business_settings_view_model.dart';
import '../../view_models/business/business_statistics_view_model.dart';
import '../../view_models/business/business_view_model.dart';
import '../../view_models/seller/seller_view_model.dart';
import '../../widgets/logo_animated_widget.dart';
import '../business/scanner_view/barcode_scanner_view.dart';
import '../business/statistics_view/statistics_view.dart';
import '../seller/settings_view.dart';
import 'seller_barcode_scanner_view.dart';
import 'seller_statistics_view.dart';

class SellerView extends StatefulWidget {
  SellerView({Key? key}) : super(key: key);

  bool isSeller = false;

  @override
  State<SellerView> createState() => _SellerViewState();
}

class _SellerViewState extends State<SellerView> {
  @override
  void initState() {
    // context.read<BusinessDashboardViewModel>().getBusinessCompany();
    // context.read<BusinessDashboardViewModel>().getBusinessShops();
    context.read<BusinessNotificationsViewModel>().getPrices();
    context.read<SellerViewModel>().getSellerProfile();
    // context.read<BusinessViewModel>().getCategories();
    // context.read<BusinessSettingsViewModel>().getWorkers();
    // context.read<BusinessPaymentViewModel>().getBonusPrices();

    context.read<SellerViewModel>().getSellerCashbackStatistics();
    context.read<BusinessStatisticsViewModel>().getClients();
    super.initState();
  }

  // Future<bool> checkIsSeller() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var res = await prefs.getBool('isSeller')!;
  //   return res;
  //   // return widget.isSeller;
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final currentIndex = context.watch<SellerViewModel>().currentIndex;

    double iconSize = 34;

    final itemsForWorkers = <SvgPicture>[
      // SvgPicture.asset(
      //   'assets/svg/home-2.svg',
      //   color: Colors.white,
      //   height: currentIndex == 0 ? iconSize : null,
      //   width: currentIndex == 0 ? iconSize : null,
      // ),
      SvgPicture.asset(
        'assets/svg/chart.svg',
        color: Colors.white,
        height: currentIndex == 0 ? iconSize : null,
        width: currentIndex == 0 ? iconSize : null,
      ),
      SvgPicture.asset(
        'assets/svg/scan-barcode.svg',
        color: Colors.white,
        height: currentIndex == 1 ? iconSize : null,
        width: currentIndex == 1 ? iconSize : null,
      ),
      SvgPicture.asset(
        'assets/svg/setting-2.svg',
        color: Colors.white,
        height: currentIndex == 2 ? iconSize : null,
        width: currentIndex == 2 ? iconSize : null,
      ),
    ];

    return context.watch<SellerViewModel>().isLoading
        ? const Scaffold(body: LogoAnimatedWidget(size: 1.5))
        : Scaffold(
            // extendBody: true,
            bottomNavigationBar: CurvedNavigationBar(
              buttonBackgroundColor: const Color.fromRGBO(103, 206, 103, 1),
              backgroundColor: Colors.transparent,
              color: const Color.fromRGBO(28, 28, 29, 1),
              index: currentIndex,
              items: itemsForWorkers,
              onTap: (index) {
                context.read<SellerViewModel>().onChange(index);
              },
            ),
            body: IndexedStack(
              index: currentIndex,
              children: [
                // const StatisticsView(),
                const SellerStatisticsView(),
                currentIndex == 1
                    ? SellerBarcodeScannerView(
                        shopId: 1,
                      )
                    : SizedBox(),
                const SettingsView(),
              ],
            ),
          );
  }
}
