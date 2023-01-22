import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../barcode_view/barcode_view.dart';
import '../client_notifications_view/client_notifications_view.dart';
import '../main_view/main_view.dart';
import '../settings_view/settings_view.dart';

class ClientHomeView extends StatefulWidget {
  const ClientHomeView({Key? key}) : super(key: key);

  @override
  State<ClientHomeView> createState() => _ClientHomeViewState();
}

class _ClientHomeViewState extends State<ClientHomeView> {
  int currentIndex = 0;
  void onChange(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> _body = [
    //   const MainView(),
    //   // const BarcodeView(),
    //   const ClientNotificationsView(),
    //   const SettingsView(),
    // ];

    var body = IndexedStack(
      index: currentIndex,
      children: const [
        MainView(),
        //  BarcodeView(),
        ClientNotificationsView(),
        SettingsView(),
      ],
    );

    List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: 'Главная',
      ),
      // const BottomNavigationBarItem(
      //   icon: Icon(Icons.credit_card),
      //   label: 'Баркод',
      // ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chat_bubble),
        label: 'Уведомления',
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
        onTap: onChange,
        type: BottomNavigationBarType.fixed,
        items: items,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black54,
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
