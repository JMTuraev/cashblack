import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/business_home_view_model.dart';
import '../main_view/main_view.dart';
import '../scanner_view/barcode_scanner_view.dart';
import '../send_notification_view/send_notification_view.dart';
import '../send_notification_view/services_view.dart';
import '../settings_view/settings_view.dart';
import '../statistics_view/statistics_view.dart';

class BusinessHomeView extends StatefulWidget {
  const BusinessHomeView({Key? key}) : super(key: key);

  @override
  State<BusinessHomeView> createState() => _BusinessHomeViewState();
}

class _BusinessHomeViewState extends State<BusinessHomeView> {
  // int currentIndex = 0;
  // void onChange(index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }
  @override
  void initState() {
    context.read<BusinessHomeViewModel>().getProfile();
    // context.read<BusinessHomeViewModel>().getStatistics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _body = const [
      MainView(),
      StatisticsView(),
      // ScannerView(),
      BarcodeScannerView(),
      ServicesView(),
      SettingsView(),
    ];

    int currentIndex = context.watch<BusinessHomeViewModel>().currentIndex;

    var body = IndexedStack(
      index: currentIndex,
      children: [
        const MainView(),
        const StatisticsView(),
        // ScannerView(),
        currentIndex == 2 ? const BarcodeScannerView() : Container(),
        const ServicesView(),
        const SettingsView(),
      ],
    );

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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: context.read<BusinessHomeViewModel>().onChange,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: items,
        backgroundColor: Colors.black,
      ),
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: body,
      // ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Container(
            //   decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Color(0xff000000), Color(0xff464646)],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //     ),
            //   ),
            //   child: body.elementAt(currentIndex),
            // ),
            // body.elementAt(currentIndex),
            body,
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
