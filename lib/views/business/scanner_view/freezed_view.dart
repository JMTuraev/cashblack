import 'package:flutter/material.dart';

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
