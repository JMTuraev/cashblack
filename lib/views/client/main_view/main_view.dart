import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/medium_title_widget.dart';
import '../../business/settings_view/payments_history_view.dart';
import 'business_list_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    context.read<ClientHomeViewModel>().getProfile();
    context.read<ClientHomeViewModel>().getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userCategoryList = context.read<ClientHomeViewModel>().userCategory;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Column(
                  children: [
                    const Center(
                      child: Text(
                        'Cashback баланс',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '0 UZS',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => PaymentsHistoryView(),
                          ),
                        );
                      },
                      child: Column(
                        children: const [
                          Icon(
                            CupertinoIcons.arrow_right_arrow_left_circle,
                            size: 30,
                          ),
                          Text('История'),
                        ],
                      ),
                    )
                  ],
                ),
                Center(child: MediumTitleWidget(text: 'Категории')),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: userCategoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (() {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => BusinessListView(),
                            ),
                          );
                        }),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Spacer(),
                              FlutterLogo(
                                size: 120,
                              ),
                              // Placeholder(
                              //   // fallbackWidth: 100,
                              //   fallbackHeight: 140,
                              // ),
                              Spacer(),
                              Text(userCategoryList[index].name.first),
                              Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
