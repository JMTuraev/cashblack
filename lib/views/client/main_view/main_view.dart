import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/client_statistics.dart';
import '../../../domain/models/client_statistics_all.dart';
import '../../../domain/models/user_category.dart';
import '../../../theme/theme_details.dart';
import '../../../utils/constants.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import 'business_list_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late Future allshopstats;
  late Future joindes;
  @override
  void initState() {
    context.read<ClientHomeViewModel>().getProfile();
    allshopstats = context.read<ClientHomeViewModel>().getAllShopStatistics();
    joindes = context.read<ClientHomeViewModel>().getJoinedCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashback'),
        bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                FutureBuilder(
                  future: allshopstats,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var stat = snapshot.data as ClientStatisticsAll;
                      return Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                NumberFormat.simpleCurrency(
                                      name: '',
                                      locale: 'ru_RU',
                                      decimalDigits: 0,
                                    ).format(stat.allSeperateCashback) +
                                    'сум',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'кэшбек',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      NumberFormat.simpleCurrency(
                                        name: '',
                                        locale: 'ru_RU',
                                        decimalDigits: 0,
                                      ).format(stat.allSum),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'сумма покупки',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.circle, size: 6),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      NumberFormat.simpleCurrency(
                                        name: '',
                                        locale: 'ru_RU',
                                        decimalDigits: 0,
                                      ).format(stat.allCashback),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'все кэшбеки',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else
                      return const Text(
                        // 'Нет активности',
                        '0 сум',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                  },
                ),
                const SizedBox(height: 6),
                const Center(child: MediumTitleWidget(text: 'Категории')),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: joindes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserCategory> userCategoryList =
                          snapshot.data as List<UserCategory>;
                      if (userCategoryList.length > 0) {
                        return Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: userCategoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) => BusinessListView(
                                          userCategory:
                                              userCategoryList[index]),
                                    ),
                                  );
                                }),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CachedNetworkImage(
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
                                          padding: const EdgeInsets.all(1),
                                          decoration: const BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(90),
                                            ),
                                          ),
                                          child: Text(
                                            userCategoryList[index]
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
                        );
                      } else {
                        return const EmptyWidget();
                      }
                    } else {
                      return const LogoAnimatedWidget(size: 1.5);
                    }
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
