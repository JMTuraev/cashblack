import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../../string_extensions.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/business/business_notifications_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../domain/models/owner/business_shop.dart';
import '../../domain/models/seller/seller_owner_profile.dart';
import '../../view_models/seller/seller_view_model.dart';
import '../../widgets/logo_animated_widget.dart';
import '../select_type_view/select_type_view.dart';
import 'edit_seller_name_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<SellerViewModel>().logout().then(
                (value) {
                  return Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (context) => const SelectTypeView(),
                    ),
                    (route) => false,
                  );
                },
              );
            },
            icon: SvgPicture.asset(
              'assets/svg/logout.svg',
              height: getH(24),
              width: getW(24),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: context.watch<SellerViewModel>().isLoading
              ? const LogoAnimatedWidget(size: 1.5)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        _ProfileCardWidget(
                          user: context.read<SellerViewModel>().sellerProfile,
                        ),
                        const SizedBox(height: 15),
                        _ShopCardWidget(
                          company: context
                              .read<SellerViewModel>()
                              .sellerProfile!
                              .shop,
                        ),
                        const SizedBox(height: 15),
                        _SubscriptionCardWidget(
                          profile:
                              context.read<SellerViewModel>().sellerProfile!,
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ShopCardWidget extends StatelessWidget {
  const _ShopCardWidget({
    super.key,
    required this.company,
  });

  final BusinessShop company;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: SizedBox(
              width: getW(60),
              height: getH(60),
              child: context.watch<BusinessSettingsViewModel>().isUploading
                  ? const CupertinoActivityIndicator()
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: company.logo ?? '',
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
                title: company.name,
              ),
              SizedBox(height: getH(4)),
              Text(
                company.address,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubscriptionCardWidget extends StatelessWidget {
  const _SubscriptionCardWidget({
    super.key,
    required this.profile,
  });

  final SellerOwnerProfile profile;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _SimpleTextWidget(
                    title: 'Абонентская плата',
                  ),
                  const SizedBox(width: 10),
                  Text(
                    context
                        .read<BusinessNotificationsViewModel>()
                        .prices
                        .where(
                          (element) =>
                              element.type == 'subscript' && element.month == 1,
                        )
                        .first
                        .price
                        .getAmountInSum(),
                    style: const TextStyle(
                      color: Color.fromRGBO(103, 206, 103, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const _SimpleTextWidget(
                    title: 'Статус',
                  ),
                  const SizedBox(width: 8),
                  Text(
                    Helpers.subsctibedChecker(profile.licence)
                        ? 'Активен'
                        : 'Не оплачен',
                    style: const TextStyle(
                      color: Color.fromRGBO(103, 206, 103, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Helpers.subsctibedChecker(profile.licence)
                  ? Row(
                      children: [
                        const _SimpleTextWidget(
                          title: 'Последный платеж',
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Helpers.subsctibedChecker(profile.licence)
                              ? profile.licence.first.startAt.getLocaleDate()
                              : 'Не оплачен',
                          style: const TextStyle(
                            color: Color.fromRGBO(103, 206, 103, 1),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 6),
              Helpers.subsctibedChecker(profile.licence)
                  ? Row(
                      children: [
                        const _SimpleTextWidget(
                          title: 'Следующий платеж',
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Helpers.subsctibedChecker(profile.licence)
                              ? profile.licence.first.endAt.getLocaleDate()
                              : 'Не оплачен',
                          style: const TextStyle(
                            color: Color.fromRGBO(103, 206, 103, 1),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileCardWidget extends StatelessWidget {
  const _ProfileCardWidget({
    super.key,
    required this.user,
  });

  final SellerOwnerProfile? user;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user == null
                  ? const _SimpleTextWidget(
                      title: 'Имя не указано',
                    )
                  : _SimpleTextWidget(
                      title: '${user?.firstName} ${user?.lastName}',
                    ),
              const SizedBox(height: 10),
              Text(
                '${user?.phone}'.phoneFormatter(),
                style: const TextStyle(
                  color: Color(0xffa3a3a3),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => EditSellerNameView(
                      user: user!,
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/svg/edit.svg',
                height: getH(24),
                width: getW(24),
              ),
            ),
          ),
        ],
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
        color: Color.fromRGBO(28, 28, 29, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
