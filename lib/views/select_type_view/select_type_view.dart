import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/main_button_widget.dart';
import '../business/auth/business_login_view/business_login_view.dart';
import '../client/auth/client_login_view/client_login_view.dart';

class SelectTypeView extends StatelessWidget {
  const SelectTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Кто вы?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MainButtonWidget(
                text: 'Бизнес',
                method: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const BusinessLoginView(),
                    ),
                    // CupertinoPageRoute(
                    //   builder: (context) => const BusinessHomeView(),
                    // ),
                  );
                },
              ),
              const SizedBox(height: 20),
              MainButtonWidget(
                text: 'Клиент',
                method: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const ClientLoginView(),
                    ),
                  );
                },
              ),
              SizedBox(height: 60),

              Text(
                'Бизнес - владелец или сотрудник магазина',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Клиент - клиент магазина',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // TODO help buttonlar kerak
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
