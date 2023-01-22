// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user_category.dart';
import '../../../domain/models/user_shop.dart';
import '../../../theme/theme_details.dart';
import '../../../utils/constants.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/medium_title_widget.dart';
import 'business_details_view.dart';

class BusinessListView extends StatelessWidget {
  final UserCategory userCategory;
  const BusinessListView({
    Key? key,
    required this.userCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(userCategory.name),
          bottom: ThemeDetails.appBarDivider,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: SafeArea(
            child: Column(
              children: [
                FutureBuilder(
                  future: context
                      .watch<ClientHomeViewModel>()
                      .getJoinedShops(userCategory.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserShop> shops = snapshot.data as List<UserShop>;
                      return Expanded(
                        child: ListView.separated(
                          itemCount: shops.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 1,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => BusinessDetailsView(
                                      userShop: shops[index],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Container(
                                  // height: MediaQuery.of(context).size.width / 4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fitHeight,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          // width: MediaQuery.of(context)
                                          //         .size
                                          //         .width /
                                          //     3,
                                          imageUrl: Constants.media +
                                              shops[index].logo,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          // color: Colors.red,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                shops[index].name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .money_dollar_circle,
                                                    size: 16,
                                                    color: Colors.green[300],
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    shops[index]
                                                        .cashbackPercentage
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text('...');
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class _SimpleTextWidget extends StatelessWidget {
  const _SimpleTextWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
