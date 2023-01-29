import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarStyle {
  // static const appBarStyle = SystemUiOverlayStyle.light;

  static const appBarStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.black, //android
    statusBarIconBrightness: Brightness.light, //android
    statusBarBrightness: Brightness.dark, //ios dark icons

    systemNavigationBarColor: Colors.black,
    systemNavigationBarDividerColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  // static final appBarStyle = SystemUiOverlayStyle(
  //   statusBarColor: AppColors.flexSchemeLight.primary,
  //   statusBarBrightness: Brightness.light,
  //   statusBarIconBrightness: Brightness.light,
  //   systemNavigationBarColor: const Color(0xFFf0f0f0),
  //   systemNavigationBarDividerColor: Colors.black,
  //   systemNavigationBarIconBrightness: Brightness.dark,
  // );
}
