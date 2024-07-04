import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/owner/business_shop.dart';
import '../../../size_config.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_statistics_view_model.dart';
import '../../../widgets/info_alert_widget.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => EditStoreView(
              shop: shop,
              fromShortcut: false,
            ),
          ),
        );
      },
      onDoubleTap: () {},
      child: _BorderContainerWidget(
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
            Expanded(
              child: Column(
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
            ),
            SizedBox(width: getW(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isBusiness
                    ? CupertinoSwitch(
                        activeColor: const Color.fromRGBO(
                          103,
                          206,
                          103,
                          1,
                        ),
                        thumbColor: Colors.white,
                        trackColor: const Color.fromRGBO(57, 57, 61, 1),
                        value: shop.status,
                        // value: true,
                        onChanged: (value) {
                          print(value);
                          if ((!value &&
                                  !context
                                      .read<BusinessStatisticsViewModel>()
                                      .shopIdsForHideOrShow
                                      .contains(shop.id)) ||
                              value) {
                            context
                                .read<BusinessDashboardViewModel>()
                                .hideOrShowShop(
                                  shop.id,
                                  value == true ? 1 : 0,
                                )
                                .then((value) {
                              context
                                  .read<BusinessDashboardViewModel>()
                                  .getBusinessShops()
                                  .then((value) {
                                Navigator.pop(context);
                                // Navigator.of(context).push(
                                //   CupertinoPageRoute(
                                //     builder: (context) => CompaniesListView(
                                //       shops: context
                                //               .read<
                                //                   BusinessDashboardViewModel>()
                                //               .businessShopsAll ??
                                //           [],
                                //     ),
                                //   ),
                                // );
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            CompaniesListView(
                                      shops: context
                                              .read<
                                                  BusinessDashboardViewModel>()
                                              .businessShopsAll ??
                                          [],
                                    ),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              });
                            });
                          } else {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return const InfoAlertWidget(
                                  title:
                                      'Это магазин с клиентами, скрытие не предусмотрено',
                                );
                              },
                            );
                          }
                        },
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
