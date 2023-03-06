import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../../widgets/active_switcher_widget.dart';
import '../../widgets/inactive_switcher_widget.dart';
import '../business/auth/business_login_view/business_login_view.dart';
import '../client/auth/client_login_view/client_login_view.dart';

class SelectTypeView extends StatefulWidget {
  const SelectTypeView({Key? key}) : super(key: key);

  @override
  State<SelectTypeView> createState() => _SelectTypeViewState();
}

class _SelectTypeViewState extends State<SelectTypeView> {
  bool business = false;
  bool client = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // overflow fix if keyboards hides and not scrollable
      body: Column(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // SizedBox(height: MediaQuery.of(context).size.width / 4),
                    const Text(
                      'Кто вы?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(height: getH(60)),
                    business
                        ? const Text(
                            'Владелец - владелец или сотрудник магазина',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(0xff575758),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : const Text(
                            'Клиент - клиент магазина',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff575758),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    SizedBox(height: getH(8)),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(28, 28, 29, 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(
                            child: client
                                ? ActiveSwitcherWidget(
                                    onPressed: () {},
                                    title: 'Клиент',
                                    fontSize: 14,
                                  )
                                : InactiveSwitcherWidget(
                                    fontSize: 14,
                                    onPressed: () {
                                      setState(() {
                                        business = false;
                                        client = true;
                                      });
                                    },
                                    title: 'Клиент',
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: business
                                ? ActiveSwitcherWidget(
                                    fontSize: 14,
                                    onPressed: () {},
                                    title: 'Владелец',
                                  )
                                : InactiveSwitcherWidget(
                                    fontSize: 14,
                                    title: 'Владелец',
                                    onPressed: () {
                                      setState(() {
                                        business = true;
                                        client = false;
                                      });
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getH(28)),
                    const Text(
                      'Мы отправим вам код подтверждения',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff575758),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: getH(15)),
                    if (business) BusinessLoginView() else ClientLoginView(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
