import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/balance.dart';
import '../../../domain/models/user.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../view_models/send_notification_view_model.dart';
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

    await context.read<SendNotificationViewModel>().getNotificationPrice();

    return [user, balance];
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<BusinessHomeViewModel>().currentIndex;

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
          var profile = snapshot.data![0] as User;
          var balancess = snapshot.data![1] as List<Balance>;

          var isBusiness = profile.groups.first.name == 'Biznes';
          var hasShopp = profile.shops.isNotEmpty;
          var isSubscribed =
              balancess.isNotEmpty ? balancess.first.isSubscribedOne : false;
          var shopId = profile.shops.isNotEmpty ? profile.shops.first.id : 0;

          var _subscribtionStartDate = balancess.isNotEmpty
              ? DateUtils.dateOnly(DateTime.parse(balancess.first.date))
              : DateTime.now();
          var _subscribtionEndDate = balancess.isNotEmpty
              ? DateUtils.dateOnly(
                  DateTime.parse(balancess.first.date)
                      .add(const Duration(days: 30)),
                )
              : DateTime.now();

          print(_subscribtionStartDate);
          print(_subscribtionEndDate);

          // print(subscribtionStartDate.compareTo(DateTime.now()));
          var isSubscribedDateActive =
              _subscribtionEndDate.compareTo(DateTime.now()) != -1;
          print(isSubscribedDateActive);

          if (isSubscribedDateActive == false && isSubscribed) {
            print('cancel subs');
            isSubscribed = false;
            context.read<BusinessHomeViewModel>().cancelSubscription();
            // futur = context.read<BusinessHomeViewModel>().getFuture();
            // setState(() {});
          }

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
                    items: isBusiness ? items : itemsForWorkers,
                    backgroundColor: Colors.black,
                  ),
                  body: SafeArea(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        isBusiness
                            ? IndexedStack(
                                index: currentIndex,
                                children: [
                                  const MainView(),
                                  const StatisticsView(),
                                  currentIndex == 2 &&
                                          isSubscribed &&
                                          isSubscribedDateActive
                                      //TODO xato

                                      ? BarcodeScannerView(
                                          shopId: shopId,
                                        )
                                      : SubscriptionView(
                                          isBusiness: isBusiness,
                                          subscribtionPrice: balancess.first
                                              .balanceShop.subscriptionPrice,
                                          shopId: profile.shops.first.id,
                                        ),
                                  const ServicesView(),
                                  const SettingsView(),
                                ],
                              )
                            : IndexedStack(
                                index: currentIndex,
                                children: [
                                  const MainView(),
                                  const StatisticsView(),
                                  //TODO xato
                                  currentIndex == 2 &&
                                          isSubscribed &&
                                          isSubscribedDateActive
                                      ? profile.isFreezed
                                          ? const FreezedView()
                                          : BarcodeScannerView(
                                              shopId: shopId,
                                            )
                                      : SubscriptionView(
                                          isBusiness: isBusiness,
                                          subscribtionPrice: balancess.first
                                              .balanceShop.subscriptionPrice,
                                          shopId: profile.shops.first.id,
                                        ),
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
