import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/client/client_shop.dart';
import '../../../size_config.dart';
import '../../../string_extensions.dart';
import '../../../view_models/client/client_dashboard_view_model.dart';
import '../../../view_models/client/client_settings_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';
import 'business_details_view.dart';
import 'business_list_view.dart';

class ClientDashboardView extends StatefulWidget {
  const ClientDashboardView({super.key});

  @override
  State<ClientDashboardView> createState() => _ClientDashboardViewState();
}

class _ClientDashboardViewState extends State<ClientDashboardView> {
  // late Future allshopstats;
  // late Future joindes;
  @override
  void initState() {
    // context.read<ClientHomeViewModel>().getProfile();
    // allshopstats = context.read<ClientHomeViewModel>().getAllShopStatistics();
    // joindes = context.read<ClientHomeViewModel>().getJoinedCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void refresh() {
      setState(() {
        print('object');
        context.read<ClientSettingsViewModel>().getClientProfile();
        context.read<ClientDashboardViewModel>().getClientCategories();
        // context.read<ClientHomeViewModel>().getProfile();
        // allshopstats =
        //     context.read<ClientHomeViewModel>().getAllShopStatistics();
        // joindes = context.read<ClientHomeViewModel>().getJoinedCategories();
      });
    }

    final itemsTemp = <ClientShop>[];
    // context.read<ClientDashboardViewModel>().clientCategories.map(
    //       (element) => element.shops
    //           .where((el) => el.cashback.isNotEmpty || el.withdraw.isNotEmpty),
    //     );

    final cCategories =
        context.read<ClientDashboardViewModel>().clientCategories;

    for (var i = 0; i < cCategories.length; i++) {
      for (var j = 0; j < cCategories[i].shops.length; j++) {
        if (cCategories[i].shops[j].cashback.isNotEmpty ||
            cCategories[i].shops[j].withdraw.isNotEmpty) {
          itemsTemp.add(cCategories[i].shops[j]);
        }
      }
    }
    itemsTemp.reversedBy((e) => double.parse(e.cashbackSum.toString()));

    final clientCategoryList = context
        .read<ClientDashboardViewModel>()
        .clientCategories
        .where((element) => element.count > 0)
        .toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        // title: const Text('Cashback'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              EasyRefresh(
                header: const MaterialHeader(),
                onRefresh: refresh,
                child: const _CashbackBalanceWidget(),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemsTemp.length > 1 ? 1 : itemsTemp.length,
                separatorBuilder: (context, index) {
                  return const SizedBox();
                },
                itemBuilder: (context, index) {
                  return LastItemWidget(clientShop: itemsTemp[index]);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Категории',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              context.watch<ClientDashboardViewModel>().isLoading
                  ? const LogoAnimatedWidget(size: 1.5)
                  : Expanded(
                      child: EasyRefresh(
                        header: const MaterialHeader(),
                        onRefresh: refresh,
                        child: clientCategoryList.isEmpty
                            ? const EmptyWidget()
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: clientCategoryList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              BusinessListView(
                                            clientCategory:
                                                clientCategoryList[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xff1c1c1d),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Padding(
                                            //TODO changes needed
                                            padding:
                                                // const EdgeInsets.only(bottom: 16),
                                                const EdgeInsets.all(33),
                                            child: CachedNetworkImage(
                                              color: Colors.white,
                                              // width: double.infinity,
                                              width: getW(80),
                                              imageUrl:
                                                  clientCategoryList[index]
                                                      .logo
                                                      .toString(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons
                                                    .home_repair_service_rounded,
                                                size: 80,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 20,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: Text(
                                                clientCategoryList[index].name,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  shadows: [
                                                    Shadow(
                                                      offset: Offset(1, 1),
                                                      blurRadius: 11,
                                                      color: Colors.black54,
                                                    ),
                                                    Shadow(
                                                      offset: Offset(1, 1),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6,
                                              ),
                                              decoration: const BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(90),
                                                ),
                                              ),
                                              child: Text(
                                                clientCategoryList[index]
                                                    .count
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
              // FutureBuilder(
              //   future: null,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       List<ClientCategory> userCategoryList =
              //           context.read<ClientDashboardViewModel>().clientCategories;
              //       if (userCategoryList.length > 0) {
              //         return Expanded();
              //       } else {
              //         return const EmptyWidget();
              //       }
              //     } else {
              //       return const LogoAnimatedWidget(size: 1.5);
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class LastItemWidget extends StatelessWidget {
  final ClientShop clientShop;

  const LastItemWidget({super.key, required this.clientShop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => BusinessDetailsView(userShop: clientShop),
          ),
        );
      },
      child: Container(
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
                  imageUrl: clientShop.logo ?? '',
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
                          clientShop.name,
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
                      Column(
                        children: [
                          Text(
                            clientShop.cashbackSum.toString().getAmountInSum(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(103, 206, 103, 1),
                            ),
                          ),
                          Text(
                            clientShop.withdrawSum.toString().getAmountInSum(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 144, 62, 1),
                            ),
                          ),
                        ],
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

class _CashbackBalanceWidget extends StatelessWidget {
  const _CashbackBalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final clientProfile = context.read<ClientSettingsViewModel>().clientProfile;
    final isLoading = context.watch<ClientSettingsViewModel>().isLoading;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(height: getH(20)),
              const Text(
                'Доступный кэшбек',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                isLoading
                    ? '...'
                    : (clientProfile?.amount ?? '0').getAmountInSum(),
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: getH(25)),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      // 'сумма покупки',
                      'Выдано',
                      style: TextStyle(
                        fontSize: 12,
                        // color: Color.fromRGBO(103, 206, 103, 1),
                        color: Color.fromRGBO(255, 144, 62, 1),
                      ),
                    ),
                    SizedBox(height: getH(6)),
                    Text(
                      isLoading
                          ? '...'
                          : (clientProfile?.withdraw ?? '0').getAmountInSum(),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        // color: Color.fromRGBO(103, 206, 103, 1),
                        color: Color.fromRGBO(255, 144, 62, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Все кэшбеки',
                      style: TextStyle(
                        fontSize: 12,
                        // color: Color.fromRGBO(75, 132, 231, 1),
                        color: Color.fromRGBO(103, 206, 103, 1),
                      ),
                    ),
                    SizedBox(height: getH(6)),
                    Text(
                      isLoading
                          ? '...'
                          : (clientProfile?.balance ?? '0').getAmountInSum(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // color: Color.fromRGBO(75, 132, 231, 1),
                        color: Color.fromRGBO(103, 206, 103, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
