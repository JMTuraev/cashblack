import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/client_statistics_all.dart';
import '../../../domain/models/user_category.dart';
import '../../../size_config.dart';
import '../../../utils/constants.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/logo_animated_widget.dart';
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
    void refresh() {
      setState(() {
        print('object');
        context.read<ClientHomeViewModel>().getProfile();
        allshopstats =
            context.read<ClientHomeViewModel>().getAllShopStatistics();
        joindes = context.read<ClientHomeViewModel>().getJoinedCategories();
      });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        // title: const Text('Cashback'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                EasyRefresh(
                  header: const MaterialHeader(),
                  onRefresh: refresh,
                  child: FutureBuilder(
                    future: allshopstats,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var stat = snapshot.data as ClientStatisticsAll;
                        return _BalanceWidget(stat: stat);
                      } else {
                        return const _TempWidget();
                      }
                    },
                  ),
                ),
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
                FutureBuilder(
                  future: joindes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserCategory> userCategoryList =
                          snapshot.data as List<UserCategory>;
                      if (userCategoryList.length > 0) {
                        return Expanded(
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
                              itemCount: userCategoryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) => BusinessListView(
                                          userCategory: userCategoryList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff1c1c1d),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          //TODO changes needed
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: CachedNetworkImage(
                                            width: double.infinity,
                                            imageUrl: Constants.media +
                                                userCategoryList[index].logo,
                                          ),
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

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({
    super.key,
    required this.stat,
  });

  final ClientStatisticsAll stat;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(height: getH(20)),
              const Text(
                'Ваш баланс',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                NumberFormat.simpleCurrency(
                      name: '',
                      locale: 'ru_RU',
                      decimalDigits: 0,
                    ).format(stat.allSeperateCashback) +
                    'сум',
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
                      NumberFormat.simpleCurrency(
                        name: '',
                        locale: 'ru_RU',
                        decimalDigits: 0,
                      ).format(stat.allSum),
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
                      NumberFormat.simpleCurrency(
                        name: '',
                        locale: 'ru_RU',
                        decimalDigits: 0,
                      ).format(stat.allCashback),
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

class _TempWidget extends StatelessWidget {
  const _TempWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(height: getH(20)),
              const Text(
                'Ваш баланс',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                '0 сум',
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
                      '0',
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
                      '0',
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
