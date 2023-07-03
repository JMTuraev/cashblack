import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/client/client_category.dart';
import '../../../domain/models/client_statistics_all.dart';
import '../../../domain/models/user_category.dart';
import '../../../size_config.dart';
import '../../../string_extensions.dart';
import '../../../utils/constants.dart';
import '../../../view_models/client/client_dashboard_view_model.dart';
import '../../../view_models/client/client_settings_view_model.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';
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
                  child: const _CashbackBalanceWidget()),
              const SizedBox(height: 50),
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
                        child: GridView.builder(
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
                                    builder: (context) => BusinessListView(
                                      clientCategory: clientCategoryList[index],
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
                                        width: double.infinity,
                                        imageUrl: clientCategoryList[index]
                                            .logo
                                            .toString(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.home_repair_service_rounded,
                                          size: 80,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 20,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
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
                                        padding: const EdgeInsets.symmetric(
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
                      'сумма покупки',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(103, 206, 103, 1),
                      ),
                    ),
                    SizedBox(height: getH(6)),
                    Text(
                      isLoading
                          ? '...'
                          : (clientProfile?.withdraw ?? '0').getAmountInSum(),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Color.fromRGBO(103, 206, 103, 1),
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
                      'все кэшбеки',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(75, 132, 231, 1),
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
                        color: Color.fromRGBO(75, 132, 231, 1),
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
