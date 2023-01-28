import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/main_button_widget.dart';
import '../settings_view/payment_view.dart';

class FreezedView extends StatelessWidget {
  const FreezedView({
    Key? key,
    // required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Ваш аккаунт сотрудника не активен',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
