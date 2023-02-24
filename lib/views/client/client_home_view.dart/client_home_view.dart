import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../size_config.dart';
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
    SizeConfig().init(context);

    var body = IndexedStack(
      index: currentIndex,
      children: const [
        MainView(),
        SettingsView(),
        ClientNotificationsView(),
      ],
    );

    double iconSize = 34;

    List<SvgPicture> items = [
      SvgPicture.asset(
        'assets/svg/home-2.svg',
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
        'assets/svg/notification.svg',
        color: Colors.white,
        height: currentIndex == 2 ? iconSize : null,
        width: currentIndex == 2 ? iconSize : null,
      ),
    ];

    // FlutterNativeSplash.remove();

    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   showUnselectedLabels: false,
      //   currentIndex: currentIndex,
      //   onTap: onChange,
      //   type: BottomNavigationBarType.fixed,
      //   items: items,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.grey,
      //   backgroundColor: Colors.black54,
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Color.fromRGBO(103, 206, 103, 1),
        backgroundColor: Colors.black,
        color: Color.fromRGBO(28, 28, 29, 1),
        index: currentIndex,
        items: items,
        onTap: onChange,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            body,
            // const Divider(
            //   height: 1,
            //   color: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}
