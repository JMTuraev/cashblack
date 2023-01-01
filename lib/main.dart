import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view_models/business_home_view_model.dart';
import 'view_models/business_login_view_model.dart';
import 'view_models/client_home_view_model.dart';
import 'view_models/client_login_view_model.dart';
import 'view_models/create_store_view_view_model.dart';
import 'view_models/settings_view_model.dart';
import 'views/business/auth/business_login_view/business_login_view.dart';
import 'views/business/business_home_view/business_home_view.dart';
import 'views/business/create_store_view/create_store_view.dart';
import 'views/client/auth/client_login_view/client_login_view.dart';
import 'views/client/client_home_view.dart/client_home_view.dart';
import 'views/select_type_view/select_type_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Future<bool> runner() async {
  final prefs = await SharedPreferences.getInstance();
  // return
  // prefs.getBool('isLogged') ?? false;
  // }

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
          child: const BusinessLoginView(),
        ),
        ChangeNotifierProvider<BusinessHomeViewModel>(
          create: (ctx) => BusinessHomeViewModel(),
        ),
        ChangeNotifierProvider<CreateStoreViewViewModel>(
          create: (ctx) => CreateStoreViewViewModel(),
          child: const CreateStoreView(),
        ),
        ChangeNotifierProvider<SettingsViewModel>(
          create: (ctx) => SettingsViewModel(),
        ),
        ChangeNotifierProvider<ClientLoginViewModel>(
          create: (ctx) => ClientLoginViewModel(),
          child: const ClientLoginView(),
        ),
        ChangeNotifierProvider<ClientHomeViewModel>(
          create: (ctx) => ClientHomeViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Cashblack',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          // colorSchemeSeed: Colors.grey[800],
          useMaterial3: true,
        ),
        // home: const BusinessHomeView(),
        home: isLogged
            ? (isBusiness ? const ClientHomeView() : const ClientHomeView())
            : const SelectTypeView(),
      ),
    );
  }
}
