import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/balance.dart';
import '../../../domain/models/user.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/logo_animated_widget.dart';
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
  // late List<Balance> balance;
  // User? user;
  // late bool isBusiness;
  // late bool hasShop;

  // late final Future userFuture;
  // late final Future balanceFuture;

  late final Future futur;

  @override
  void initState() {
//     context.read<BusinessHomeViewModel>().getBalance();
//     context.read<BusinessHomeViewModel>().getProfile();

//     currentIndex = context.watch<BusinessHomeViewModel>().currentIndex;
//     balance = context.watch<BusinessHomeViewModel>().balance;
//     user = context.watch<BusinessHomeViewModel>().user!;

    // context.read<BusinessHomeViewModel>().getBalance();
    // userFuture = context.read<BusinessHomeViewModel>().getProfile();
    // getData();
    // setState(() {});
    // futur = getFuture();
    futur = context.read<BusinessHomeViewModel>().getFuture();
    super.initState();
  }

  // void getData() async {
  //   balance = await context.read<BusinessHomeViewModel>().getBalance();
  //   user = await context.read<BusinessHomeViewModel>().getProfile();
  //   isBusiness = user?.groups.first.name == 'Biznes';
  //   hasShop = user?.shops.isNotEmpty ?? false;
  // }

  Future<List<Object>> getFuture() async {
    User user = await context.read<BusinessHomeViewModel>().getProfile();
    List<Balance> balance =
        await context.read<BusinessHomeViewModel>().getBalance();

    return [user, balance];
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<BusinessHomeViewModel>().currentIndex;

    // List<Balance> balance = context.watch<BusinessHomeViewModel>().balance;
    // User user = context.watch<BusinessHomeViewModel>().user!;
    // var isBusiness = user.groups.first.name == 'Biznes';
    // bool hasShop = user.shops.isNotEmpty;

    // IndexedStack body = IndexedStack(
    //   index: currentIndex,
    //   children: const [
    //     MainView(),
    //     MainView(),
    //     MainView(),
    //     MainView(),
    //     MainView(),
    //   ],
    // );
    // IndexedStack bodyForWorker = IndexedStack(
    //   index: currentIndex,
    //   children: const [
    //     MainView(),
    //     MainView(),
    //     MainView(),
    //     MainView(),
    //   ],
    // );

    // if (user != null && balance != null) {
    //   body = IndexedStack(
    //     index: currentIndex,
    //     children: [
    //       const MainView(),
    //       const StatisticsView(),
    //       //TODO change
    //       //     // currentIndex == 2

    //       currentIndex == 2 && !balance.first.isSubscribedOne
    //           ? const BarcodeScannerView()
    //           : SubscriptionView(isBusiness: isBusiness),
    //       const ServicesView(),
    //       const SettingsView(),
    //     ],
    //   );

    //   bodyForWorker = IndexedStack(
    //     index: currentIndex,
    //     children: [
    //       const MainView(),
    //       const StatisticsView(),
    //       //TODO change
    //       // currentIndex == 2 && balance.first.balanceShop.isSubscribed
    //       //  xato
    //       currentIndex == 2 && balance.first.isSubscribedOne
    //           ? const BarcodeScannerView()
    //           : !user!.isFreezed
    //               ? SubscriptionView(isBusiness: isBusiness)
    //               : const FreezedView(),
    //       const SettingsView(),
    //     ],
    //   );
    // }

    const List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: 'Главная',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chart_pie),
        label: 'Статистика',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.viewfinder),
        label: 'Сканер',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.square_grid_2x2),
        label: 'Сервисы',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        label: 'Настройки',
      ),
    ];

    const List<BottomNavigationBarItem> itemsForWorkers = [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: 'Главная',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chart_pie),
        label: 'Статистика',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.viewfinder),
        label: 'Сканер',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        label: 'Настройки',
      ),
    ];

    // FlutterNativeSplash.remove();

    return FutureBuilder(
      future: futur,
      // initialData: InitialData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userr = snapshot.data![0] as User;
          var balancess = snapshot.data![1] as List<Balance>;

          var usBusinesss = userr.groups.first.name == 'Biznes';
          var hasShopp = userr.shops.isNotEmpty;
          var isSubscribed = balancess.first.isSubscribedOne;

          return !hasShopp
              ? const CreateStoreView()
              : Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    showUnselectedLabels: false,
                    currentIndex: currentIndex,
                    onTap: context.read<BusinessHomeViewModel>().onChange,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    items: usBusinesss ? items : itemsForWorkers,
                    backgroundColor: Colors.black,
                  ),
                  body: SafeArea(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        usBusinesss
                            ? IndexedStack(
                                index: currentIndex,
                                children: [
                                  const MainView(),
                                  const StatisticsView(),
                                  //TODO change
                                  //     // currentIndex == 2

                                  currentIndex == 2 && !isSubscribed
                                      //TODO xato

                                      ? const BarcodeScannerView()
                                      : SubscriptionView(
                                          isBusiness: usBusinesss),
                                  const ServicesView(),
                                  const SettingsView(),
                                ],
                              )
                            : IndexedStack(
                                index: currentIndex,
                                children: [
                                  const MainView(),
                                  const StatisticsView(),
                                  //TODO change
                                  // currentIndex == 2 && balance.first.balanceShop.isSubscribed
                                  //TODO xato
                                  currentIndex == 2 && !isSubscribed
                                      ? const BarcodeScannerView()
                                      : !userr.isFreezed
                                          ? SubscriptionView(
                                              isBusiness: usBusinesss)
                                          : const FreezedView(),
                                  const SettingsView(),
                                ],
                              ),
                        const Divider(
                          height: 1,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
        } else
          return const Scaffold(
            body: Scaffold(
              body: Center(
                child: LogoAnimatedWidget(size: 1.5),
              ),
            ),
          );
      },
    );
  }
}
