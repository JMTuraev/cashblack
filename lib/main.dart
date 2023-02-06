import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/app_bar_style.dart';
import 'view_models/balance_view_model.dart';
import 'view_models/business_home_view_model.dart';
import 'view_models/business_login_view_model.dart';
import 'view_models/client_home_view_model.dart';
import 'view_models/client_login_view_model.dart';
import 'view_models/create_store_view_view_model.dart';
import 'view_models/payment_client_view_model.dart';
import 'view_models/send_notification_view_model.dart';
import 'view_models/statistics_view_model.dart';
import 'views/business/auth/business_login_view/business_login_view.dart';
import 'views/business/business_home_view/business_home_view.dart';
import 'views/business/create_store_view/create_store_view.dart';
import 'views/client/auth/client_login_view/client_login_view.dart';
import 'views/client/client_home_view.dart/client_home_view.dart';
import 'views/select_type_view/select_type_view.dart';
import 'widgets/dismiss_keyboard_widget.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  final prefs = await SharedPreferences.getInstance();

  Intl.defaultLocale = 'ru_RU';
  await initializeDateFormatting('ru_RU', null);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    MyApp(
      isLogged: prefs.getBool('isLogged') ?? false,
      isBusiness: prefs.getBool('isBusiness') ?? false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.isLogged,
    required this.isBusiness,
  }) : super(key: key);

  final bool isLogged;
  final bool isBusiness;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BusinessLoginViewModel>(
          create: (ctx) => BusinessLoginViewModel(),
          child: BusinessLoginView(),
        ),
        ChangeNotifierProvider<BusinessHomeViewModel>(
          create: (ctx) => BusinessHomeViewModel(),
        ),
        ChangeNotifierProvider<CreateStoreViewViewModel>(
          create: (ctx) => CreateStoreViewViewModel(),
          child: const CreateStoreView(),
        ),
        ChangeNotifierProvider<StatisticsViewModel>(
          create: (ctx) => StatisticsViewModel(),
        ),
        ChangeNotifierProvider<ClientLoginViewModel>(
          create: (ctx) => ClientLoginViewModel(),
          child: ClientLoginView(),
        ),
        ChangeNotifierProvider<ClientHomeViewModel>(
          create: (ctx) => ClientHomeViewModel(),
        ),
        ChangeNotifierProvider<PaymentClientViewModel>(
          create: (ctx) => PaymentClientViewModel(),
        ),
        ChangeNotifierProvider<SendNotificationViewModel>(
          create: (ctx) => SendNotificationViewModel(),
        ),
        ChangeNotifierProvider<BalanceViewModel>(
          create: (ctx) => BalanceViewModel(),
        ),
      ],
      child: DismissKeyboardWidget(
        child: MaterialApp(
          title: 'Cashblack',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            backgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              systemOverlayStyle: AppBarStyle.appBarStyle,
              elevation: 0,
              centerTitle: true,
              scrolledUnderElevation: 0,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            cardTheme: CardTheme(
              color: Colors.grey.shade900,
              elevation: 0,
            ),
            useMaterial3: true,
          ),
          home: isLogged
              ? (isBusiness ? const BusinessHomeView() : const ClientHomeView())
              : const SelectTypeView(),
        ),
      ),
    );
  }
}
