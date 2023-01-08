import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user_category.dart';
import '../../../utils/constants.dart';
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
    // context.read<ClientHomeViewModel>().getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var userCategoryList = context.watch<ClientHomeViewModel>().userCategory;
    // var userShops = context.watch<ClientHomeViewModel>().userShop;
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
                FutureBuilder(
                  future: context
                      .watch<ClientHomeViewModel>()
                      .getJoinedCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserCategory> userCategoryList =
                          snapshot.data as List<UserCategory>;

                      return Expanded(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: userCategoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              // ignore: unnecessary_parenthesis
                              onTap: (() {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => BusinessListView(
                                      shopId: userCategoryList[index].id,
                                      name: userCategoryList[index].name,
                                    ),
                                  ),
                                );
                              }),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Column(
                                  children: [
                                    Spacer(),
                                    CachedNetworkImage(
                                      width: 150,
                                      imageUrl: Constants.media +
                                          userCategoryList[index].logo,
                                    ),
                                    // Placeholder(
                                    //   // fallbackWidth: 100,
                                    //   fallbackHeight: 140,
                                    // ),
                                    Spacer(),
                                    Text(userCategoryList[index].name),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else
                      return Text('');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
