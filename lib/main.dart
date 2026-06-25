import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/app_bar_style.dart';
import 'view_models/balance_view_model.dart';
import 'view_models/business/business_dashboard_view_model.dart';
import 'view_models/business/business_login_view_model.dart';
import 'view_models/business/business_notifications_view_model.dart';
import 'view_models/business/business_payment_view_model.dart';
import 'view_models/business/business_settings_view_model.dart';
import 'view_models/business/business_statistics_view_model.dart';
import 'view_models/business/business_view_model.dart';
import 'view_models/client/client_dashboard_view_model.dart';
import 'view_models/client/client_login_view_model.dart';
import 'view_models/client/client_settings_view_model.dart';
import 'view_models/client/client_view_model.dart';
import 'view_models/client_home_view_model.dart';
import 'view_models/create_store_view_view_model.dart';
import 'view_models/payment_client_view_model.dart';
import 'view_models/seller/seller_view_model.dart';
import 'view_models/send_notification_view_model.dart';
import 'view_models/sklad/sklad_view_model.dart';
import 'view_models/statistics_view_model.dart';
import 'views/business/auth/business_login_view/business_login_view.dart';
import 'views/business/business_view.dart';
import 'views/business/create_store_view/create_store_view.dart';
import 'views/client/auth/client_login_view/client_login_view.dart';
import 'views/client/client_view.dart';
import 'views/select_type_view/select_type_view.dart';
import 'views/seller/seller_view.dart';
import 'widgets/dismiss_keyboard_widget.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // await SystemChrome.setEnabledSystemUIOverlays(
  //     [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  final prefs = await SharedPreferences.getInstance();

  Intl.defaultLocale = 'ru_RU';
  await initializeDateFormatting('ru_RU');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//  await prefs.clear();

  runApp(
    MyApp(
      isLogged: prefs.getBool('isLogged') ?? false,
      isBusiness: prefs.getBool('isBusiness') ?? false,
      isSeller: prefs.getBool('isSeller') ?? false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isLogged,
    required this.isBusiness,
    required this.isSeller,
  });

  final bool isLogged;
  final bool isBusiness;
  final bool isSeller;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //business
        ChangeNotifierProvider<BusinessLoginViewModel>(
          create: (ctx) => BusinessLoginViewModel(),
          child: const BusinessLoginView(),
        ),
        ChangeNotifierProvider<BusinessViewModel>(
          create: (ctx) => BusinessViewModel(),
        ),
        ChangeNotifierProvider<BusinessDashboardViewModel>(
          create: (ctx) => BusinessDashboardViewModel(),
        ),
        ChangeNotifierProvider<BusinessSettingsViewModel>(
          create: (ctx) => BusinessSettingsViewModel(),
        ),
        ChangeNotifierProvider<BusinessNotificationsViewModel>(
          create: (ctx) => BusinessNotificationsViewModel(),
        ),
        ChangeNotifierProvider<BusinessPaymentViewModel>(
          create: (ctx) => BusinessPaymentViewModel(),
        ),
        ChangeNotifierProvider<BusinessStatisticsViewModel>(
          create: (ctx) => BusinessStatisticsViewModel(),
        ),
        //client
        ChangeNotifierProvider<ClientViewModel>(
          create: (ctx) => ClientViewModel(),
        ),
        ChangeNotifierProvider<ClientDashboardViewModel>(
          create: (ctx) => ClientDashboardViewModel(),
        ),
        ChangeNotifierProvider<ClientSettingsViewModel>(
          create: (ctx) => ClientSettingsViewModel(),
        ),
        //others
        ChangeNotifierProvider<CreateStoreViewViewModel>(
          create: (ctx) => CreateStoreViewViewModel(),
          child: const CreateStoreView(),
        ),
        ChangeNotifierProvider<StatisticsViewModel>(
          create: (ctx) => StatisticsViewModel(),
        ),
        ChangeNotifierProvider<ClientLoginViewModel>(
          create: (ctx) => ClientLoginViewModel(),
          child: const ClientLoginView(),
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
        //seller
        ChangeNotifierProvider<SellerViewModel>(
          create: (ctx) => SellerViewModel(),
        ),
        // sklad
        ChangeNotifierProvider<SkladViewModel>(
          create: (ctx) => SkladViewModel(),
        ),
      ],
      child: DismissKeyboardWidget(
        child: MaterialApp(
          title: 'Cashblack',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
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
            cardTheme: CardThemeData(
              color: Colors.grey.shade900,
              elevation: 0,
            ),
            useMaterial3: true,
          ),
          home: isLogged
              ? (isBusiness
                  ? (isSeller ? SellerView() : BusinessView())
                  : const ClientView())
              : const SelectTypeView(),
        ),
      ),
    );
  }
}
