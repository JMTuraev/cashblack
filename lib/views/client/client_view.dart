import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import '../../view_models/client/client_dashboard_view_model.dart';
import '../../view_models/client/client_settings_view_model.dart';
import '../../view_models/client/client_view_model.dart';
import '../../widgets/logo_animated_widget.dart';
import 'client_notifications_view/client_notifications_view.dart';
import 'client_dashboard_view.dart/client_dashboard_view.dart';
import 'settings_view/settings_view.dart';

class ClientView extends StatefulWidget {
  const ClientView({Key? key}) : super(key: key);

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  // int currentIndex = 0;

  Timer? timer;


  @override
  void initState() {
    context.read<ClientSettingsViewModel>().getClientProfile();
    context.read<ClientDashboardViewModel>().getClientCategories();
    context.read<ClientDashboardViewModel>().getNotifications();

     //todo auto check
    timer = Timer.periodic(
      const Duration(seconds: 15),
      (Timer t) {
        context.read<ClientSettingsViewModel>().getClientProfile();
        context.read<ClientDashboardViewModel>().getClientCategories();
      },
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    int currentIndex = context.watch<ClientViewModel>().currentIndex;

    var body = IndexedStack(
      index: currentIndex,
      children: const [
        ClientDashboardView(),
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
        onTap: (value) {
          context.read<ClientViewModel>().onChange(value);
        },
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
