import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../domain/models/owner/business_shop.dart';
import '../../../size_config.dart';
import '../create_store_view/edit_store_view.dart';

/// {@template companies_list_view}
/// CompaniesListView widget
/// {@endtemplate}
class CompaniesListView extends StatelessWidget {
  /// {@macro companies_list_view}
  const CompaniesListView({super.key, required this.shops});

  final List<BusinessShop> shops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список компании'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ListView.separated(
            itemCount: shops.length,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, index) {
              return ShopCardWidget(shop: shops[index], isBusiness: true);
            },
          ),
        ),
      ),
    );
  }
}

class ShopCardWidget extends StatelessWidget {
  const ShopCardWidget({
    super.key,
    required this.shop,
    required this.isBusiness,
  });

  final BusinessShop shop;
  final bool isBusiness;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: GestureDetector(
        onTap: () {},
        onDoubleTap: () {},
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: SizedBox(
                width: getW(60),
                height: getH(60),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: shop.logo ?? '',
                  errorWidget: (context, url, error) => const Icon(
                    Icons.home_repair_service_rounded,
                    size: 40,
                  ),
                ),
              ),
            ),
            SizedBox(width: getW(18)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SimpleTextWidget(
                  title: shop.name,
                ),
                SizedBox(height: getH(4)),
                Text(
                  shop.address,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isBusiness
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => EditStoreView(
                                shop: shop,
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/svg/edit.svg',
                          height: getH(24),
                          width: getW(24),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BorderContainerWidget extends StatelessWidget {
  const _BorderContainerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: getW(23),
        vertical: getH(15),
      ),
      decoration: const BoxDecoration(
        // border: Border.all(
        //   width: 1,
        //   color: Colors.white24,
        // ),
        color: Color.fromRGBO(28, 28, 29, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: child,
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
