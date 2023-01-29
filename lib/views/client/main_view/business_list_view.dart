import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user_category.dart';
import '../../../domain/models/user_shop.dart';
import '../../../theme/theme_details.dart';
import '../../../utils/constants.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/logo_animated_widget.dart';
import 'business_details_view.dart';

class BusinessListView extends StatefulWidget {
  final UserCategory userCategory;
  const BusinessListView({
    Key? key,
    required this.userCategory,
  }) : super(key: key);

  @override
  State<BusinessListView> createState() => _BusinessListViewState();
}

class _BusinessListViewState extends State<BusinessListView> {
  late Future joineds;

  @override
  void initState() {
    super.initState();
    joineds = context
        .read<ClientHomeViewModel>()
        .getJoinedShops(widget.userCategory.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.userCategory.name),
          bottom: ThemeDetails.appBarDivider,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: SafeArea(
            child: Column(
              children: [
                FutureBuilder(
                  future: joineds,
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
                                          imageUrl: Constants.media +
                                              shops[index].logo,
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Colors.transparent,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
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
                      return Center(child: const LogoAnimatedWidget(size: 1.5));
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
