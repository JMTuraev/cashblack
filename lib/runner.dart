import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin Runner {
  static Future<ThemeMode> themeRunner() async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          // statusBarColor: AppColors.flexSchemeLight.primary,
          // statusBarBrightness: Brightness.light,
          // statusBarIconBrightness: Brightness.light,
          // systemNavigationBarColor: const Color(0xFFf0f0f0),
          // systemNavigationBarDividerColor: Colors.black,
          // systemNavigationBarIconBrightness: Brightness.dark,
          ),
    );

    ThemeMode themeMode;

    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode');

    if (isDarkMode == null) {
      themeMode = ThemeMode.system;
    } else {
      themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    }

    return themeMode;
  }
}
