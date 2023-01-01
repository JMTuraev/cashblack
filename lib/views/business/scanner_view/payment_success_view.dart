import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../business_home_view/business_home_view.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(child: MediumTitleWidget(text: 'Счет пополнено')),
                const SizedBox(height: 20),
                MainButtonWidget(
                  text: 'OK',
                  method: () {
                    context.read<BusinessHomeViewModel>().onChange(0);
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => BusinessHomeView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
