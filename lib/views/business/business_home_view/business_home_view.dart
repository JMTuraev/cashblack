import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/business_home_view_model.dart';
import '../main_view/main_view.dart';
import '../scanner_view/scanner_view.dart';
import '../send_notification_view/send_notification_view.dart';
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
  Widget build(BuildContext context) {
    List<Widget> body = const [
      MainView(),
      StatisticsView(),
      ScannerView(),
      SendNotificationView(),
      SettingsView(),
    ];

    int currentIndex = context.watch<BusinessHomeViewModel>().currentIndex;

    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: 'Главная',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chart_bar),
        label: 'Статистика',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.viewfinder),
        label: 'Сканер',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chat_bubble),
        label: 'Отправка',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        label: 'Настройки',
      ),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: context.read<BusinessHomeViewModel>().onChange,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: items,
      ),
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: body,
      // ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            body.elementAt(currentIndex),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
