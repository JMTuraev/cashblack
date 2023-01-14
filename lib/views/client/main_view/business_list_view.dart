import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user_shop.dart';
import '../../../utils/constants.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/medium_title_widget.dart';
import 'business_details_view.dart';

class BusinessListView extends StatelessWidget {
  const BusinessListView({super.key, required this.shopId, required this.name});

  final int shopId;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: MediumTitleWidget(text: name),
            ),
            FutureBuilder(
              future:
                  context.watch<ClientHomeViewModel>().getJoinedShops(shopId),
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
                        // return _BrandCardWidget();
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => BusinessDetailsView(
                                  id: shops[index].id,
                                  name: shops[index].name,
                                ),
                              ),
                            );
                          },
                          title: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: CachedNetworkImage(
                                    imageUrl:
                                        Constants.media + shops[index].logo),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _SimpleTextWidget(
                                    title: shops[index].name,
                                  ),
                                  const SizedBox(height: 10),
                                  // Row(
                                  //   children: [
                                  //     const Icon(
                                  //       CupertinoIcons.money_dollar_circle,
                                  //       size: 16,
                                  //     ),
                                  //     const SizedBox(width: 4),
                                  //     Text(shops[index].id.toString()),
                                  //   ],
                                  // ),
                                ],
                              )
                            ],
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
