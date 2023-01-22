// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/main_button_widget.dart';
import '../business/auth/business_login_view/business_login_view.dart';
import '../client/auth/client_login_view/client_login_view.dart';

class SelectTypeView extends StatefulWidget {
  const SelectTypeView({Key? key}) : super(key: key);

  @override
  State<SelectTypeView> createState() => _SelectTypeViewState();
}

class _SelectTypeViewState extends State<SelectTypeView> {
  List<bool> selections = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Spacer(),
                SizedBox(height: MediaQuery.of(context).size.width / 4),
                const Text(
                  'Кто вы?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Бизнес - владелец или сотрудник магазина',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Клиент - клиент магазина',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: ToggleButtons(
                    isSelected: selections,
                    onPressed: (index) {
                      setState(() {
                        switch (index) {
                          case 0:
                            selections = [true, false];
                            break;
                          case 1:
                            selections = [false, true];
                            break;
                          default:
                        }
                      });
                    },
                    selectedColor: Colors.white,
                    fillColor: Colors.grey[800],
                    renderBorder: false,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    selectedBorderColor: Colors.grey[800],
                    // focusColor: Colors.gren,
                    // hoverColor: Colors.blue,
                    splashColor: Colors.grey[700],
                    children: const [
                      _ButtonWidget(
                        title: 'Бизнес',
                      ),
                      _ButtonWidget(
                        title: 'Клиент',
                      ),
                    ],
                    // color: Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                selections[0] == true
                    ? const BusinessLoginView()
                    : const ClientLoginView(),
                // MainButtonWidget(
                //   text: 'Бизнес',
                //   method: () {
                //     Navigator.of(context).push(
                //       CupertinoPageRoute(
                //         builder: (context) => const BusinessLoginView(),
                //       ),
                //       // CupertinoPageRoute(
                //       //   builder: (context) => const BusinessHomeView(),
                //       // ),
                //     );
                //   },
                // ),
                // const SizedBox(height: 20),
                // MainButtonWidget(
                //   text: 'Клиент',
                //   method: () {
                //     Navigator.of(context).push(
                //       CupertinoPageRoute(
                //         builder: (context) => const ClientLoginView(),
                //       ),
                //     );
                //   },
                // ),
                // const SizedBox(height: 60),

                // TODO help buttonlar kerak
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
