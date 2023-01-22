import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user_category.dart';
import '../../../theme/theme_details.dart';
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
      appBar: AppBar(
        title: const Text('Cashback'),
        bottom: ThemeDetails.appBarDivider,
        // elevation: 1,
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  //TODO
                  '100 000 сум',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 6),
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
                          // physics: NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
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
                                        userCategory: userCategoryList[index]),
                                  ),
                                );
                              }),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Spacer(),
                                    CachedNetworkImage(
                                      // width: 120,
                                      width: double.infinity,
                                      imageUrl: Constants.media +
                                          userCategoryList[index].logo,
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          userCategoryList[index].name,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(4, 4),
                                                blurRadius: 11,
                                                color: Colors.black54,
                                              ),
                                              Shadow(
                                                offset: Offset(4, 4),
                                                blurRadius: 11,
                                                color: Colors.white54,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 6,
                                      right: 6,
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(90),
                                          ),
                                        ),
                                        child: Text(
                                          userCategoryList[index]
                                              .count
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Placeholder(
                                    //   // fallbackWidth: 100,
                                    //   fallbackHeight: 140,
                                    // ),
                                    // Spacer(),
                                    // Text(userCategoryList[index].name),
                                    // Spacer(),
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
