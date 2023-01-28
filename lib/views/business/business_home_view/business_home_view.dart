import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/balance.dart';
import '../../../domain/models/user.dart';
import '../../../view_models/business_home_view_model.dart';
import '../create_store_view/create_store_view.dart';
import '../main_view/main_view.dart';
import '../scanner_view/barcode_scanner_view.dart';
import '../scanner_view/freezed_view.dart';
import '../scanner_view/subscription_view.dart';
import '../send_notification_view/services_view.dart';
import '../settings_view/settings_view.dart';
import '../statistics_view/statistics_view.dart';

class BusinessHomeView extends StatefulWidget {
  const BusinessHomeView({Key? key}) : super(key: key);

  @override
  State<BusinessHomeView> createState() => _BusinessHomeViewState();
}

class _BusinessHomeViewState extends State<BusinessHomeView> {
// late int currentIndex;
  late List<Balance> balance;
  late User user;
  late bool isBusiness;
  late bool hasShop;

  @override
  void initState() {
//     context.read<BusinessHomeViewModel>().getBalance();
//     context.read<BusinessHomeViewModel>().getProfile();

//     currentIndex = context.watch<BusinessHomeViewModel>().currentIndex;
//     balance = context.watch<BusinessHomeViewModel>().balance;
//     user = context.watch<BusinessHomeViewModel>().user!;

    // context.read<BusinessHomeViewModel>().getBalance();
    // context.read<BusinessHomeViewModel>().getProfile();
    getData();
    setState(() {});
    super.initState();
  }

  void getData() async {
    balance = await context.read<BusinessHomeViewModel>().getBalance();
    user = await context.read<BusinessHomeViewModel>().getProfile();
    isBusiness = user.groups.first.name == 'Biznes';
    hasShop = user.shops.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<BusinessHomeViewModel>().currentIndex;

    // List<Balance> balance = context.watch<BusinessHomeViewModel>().balance;
    // User user = context.watch<BusinessHomeViewModel>().user!;
    // var isBusiness = user.groups.first.name == 'Biznes';
    // bool hasShop = user.shops.isNotEmpty;

    IndexedStack body = IndexedStack(
      index: currentIndex,
      children: const [
        MainView(),
        MainView(),
        MainView(),
        MainView(),
        MainView(),
      ],
    );
    IndexedStack bodyForWorker = IndexedStack(
      index: currentIndex,
      children: const [
        MainView(),
        MainView(),
        MainView(),
        MainView(),
      ],
    );

    if (user != null && balance != null) {
      body = IndexedStack(
        index: currentIndex,
        children: [
          const MainView(),
          const StatisticsView(),
          //todo change
          //     // currentIndex == 2

          currentIndex == 2 && !balance.first.isSubscribedOne
              ? const BarcodeScannerView()
              : SubscriptionView(isBusiness: isBusiness),
          const ServicesView(),
          const SettingsView(),
        ],
      );

      bodyForWorker = IndexedStack(
        index: currentIndex,
        children: [
          const MainView(),
          const StatisticsView(),
          //todo change
          // currentIndex == 2 && balance.first.balanceShop.isSubscribed
          //  xato
          currentIndex == 2 && balance.first.isSubscribedOne
              ? const BarcodeScannerView()
              : !user.isFreezed
                  ? SubscriptionView(isBusiness: isBusiness)
                  : const FreezedView(),
          const SettingsView(),
        ],
      );
    }

    List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: 'Главная',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chart_pie),
        label: 'Статистика',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.viewfinder),
        label: 'Сканер',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.square_grid_2x2),
        label: 'Сервисы',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        label: 'Настройки',
      ),
    ];

    List<BottomNavigationBarItem> itemsForWorkers = [
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: 'Главная',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chart_pie),
        label: 'Статистика',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.viewfinder),
        label: 'Сканер',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        label: 'Настройки',
      ),
    ];

    // FlutterNativeSplash.remove();

    return !hasShop
        ? CreateStoreView()
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              currentIndex: currentIndex,
              onTap: context.read<BusinessHomeViewModel>().onChange,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              items: isBusiness ? items : itemsForWorkers,
              backgroundColor: Colors.black,
            ),
            body: SafeArea(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  isBusiness ? body : bodyForWorker,
                  const Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
  }
}
