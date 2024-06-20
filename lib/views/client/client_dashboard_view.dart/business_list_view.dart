import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../domain/models/client/client_category.dart';
import '../../../domain/models/client/client_shop.dart';
import '../../../size_config.dart';
import 'business_details_view.dart';

class BusinessListView extends StatefulWidget {
  final ClientCategory clientCategory;
  const BusinessListView({
    super.key,
    required this.clientCategory,
  });

  @override
  State<BusinessListView> createState() => _BusinessListViewState();
}

class _BusinessListViewState extends State<BusinessListView> {
  // late Future joineds;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<ClientShop> shops = [
    //   ClientShop(
    //     id: 200,
    //     name: 'nameasdas',
    //     logo: 'logo',
    //     address: 'address',
    //     waymark: 'waymark',
    //     percent: 'percent',
    //     categoryShopId: 11,
    //     clientCompany: ClientCompany(id: 1, name: 'name'),
    //     amount: 123123,
    //     cashback: List.empty(),
    //   ),
    //   ClientShop(
    //     id: 100,
    //     name: 'namdeas',
    //     logo: 'logo',
    //     address: 'address',
    //     waymark: 'waymark',
    //     percent: 'percent',
    //     categoryShopId: 11,
    //     clientCompany: ClientCompany(id: 1, name: 'name'),
    //     amount: 123123,
    //     cashback: List.empty(),
    //   ),
    // ];
    // final shopsList = widget.clientCategory.shops.where(
    // (element) => element.cashback.isNotEmpty || element.withdraw.isNotEmpty,
    // );
    final shopsList = widget.clientCategory.shops;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clientCategory.name),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: EasyRefresh(
          header: const MaterialHeader(),
          onRefresh: () {
            setState(() {
              // joineds = context
              //     .read<ClientHomeViewModel>()
              //     .getJoinedShops(widget.userCategory.id);
            });
          },
          child: Container(
            child: ListView.separated(
              // shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: shopsList.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: getH(10),
                );
              },
              itemBuilder: (context, index) {
                return _ItemWidget(
                  shops: widget.clientCategory.shops,
                  index: index,
                );
                // return Text(widget.clientCategory.shops[index].name);
              },
            ),
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

  final List<ClientShop> shops;
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
                  imageUrl: shops[index].logo ?? '',
                  placeholder: (context, url) => Container(
                    color: Colors.transparent,
                    height: getW(80),
                    width: getW(80),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.home_repair_service_rounded,
                    size: 40,
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
                        '${shops[index].percent}%',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(201, 247, 158, 1),
                        ),
                      ),
                      SizedBox(width: getW(10)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleTextWidget extends StatelessWidget {
  const _SimpleTextWidget({
    super.key,
    required this.title,
  });

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
