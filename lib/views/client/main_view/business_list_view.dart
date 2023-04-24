import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user_category.dart';
import '../../../domain/models/user_shop.dart';
import '../../../size_config.dart';
import '../../../utils/constants.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/empty_widget.dart';
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
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: EasyRefresh(
          header: const MaterialHeader(),
          onRefresh: () {
            setState(() {
              joineds = context
                  .read<ClientHomeViewModel>()
                  .getJoinedShops(widget.userCategory.id);
            });
          },
          child: Column(
            children: [
              FutureBuilder(
                future: joineds,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UserShop> shops = snapshot.data as List<UserShop>;
                    if (shops.length > 0) {
                      return Expanded(
                        child: ListView.separated(
                          itemCount: shops.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: getH(10),
                            );
                          },
                          itemBuilder: (context, index) {
                            return _ItemWidget(shops: shops, index: index);
                          },
                        ),
                      );
                    } else {
                      return const Center(child: EmptyWidget());
                    }
                  } else {
                    // return const Center(child: LogoAnimatedWidget(size: 1.5));
                    return Expanded(
                      child: Column(
                        children: [
                          Spacer(),
                          LogoAnimatedWidget(size: 1.5),
                          Spacer(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    super.key,
    required this.shops,
    required this.index,
  });

  final List<UserShop> shops;
  final int index;

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getH(20)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff1c1c1d),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getW(12),
            vertical: getH(6),
          ),
          child: Row(
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  height: getW(80),
                  width: getW(80),
                  imageUrl: Constants.media + shops[index].logo,
                  placeholder: (context, url) => Container(
                    color: Colors.transparent,
                    height: getW(80),
                    width: getW(80),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Spacer(),
                      SizedBox(width: getW(10)),
                      Expanded(
                        child: Text(
                          shops[index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      // const Spacer(),
                      SizedBox(width: getW(10)),

                      SvgPicture.asset(
                        'assets/svg/tag.svg',
                        color: Colors.white,
                        height: getH(26),
                        width: getH(26),
                      ),
                      SizedBox(width: getW(4)),
                      Text(
                        shops[index].cashbackPercentage.toString() + '%',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(201, 247, 158, 1),
                        ),
                      ),
                      SizedBox(width: getW(10)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
