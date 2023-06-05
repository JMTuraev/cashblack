import 'dart:convert' show utf8, base64;

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user.dart';
import '../../../string_extensions.dart';
import '../../../size_config.dart';
import '../../../view_models/client/client_settings_view_model.dart';
import '../../../view_models/client/client_view_model.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/logo_animated_widget.dart';
import '../../../widgets/small_title_widget.dart';
import '../../../widgets/text_button_widget.dart';
import '../../select_type_view/select_type_view.dart';
import 'edit_name_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // late Future userFuture;

  @override
  void initState() {
    // userFuture = context.read<ClientHomeViewModel>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var client = context.read<ClientSettingsViewModel>().clientProfile;
    // print(base64.encode(utf8.encode(client!.phone)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        // bottom: ThemeDetails.appBarDivider,
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<ClientViewModel>().logout().then(
                    (value) => Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const SelectTypeView(),
                      ),
                      (route) => false,
                    ),
                  );
            },
            icon: SvgPicture.asset(
              'assets/svg/logout.svg',
              height: getH(24),
              width: getW(24),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: context.watch<ClientSettingsViewModel>().isLoading
              ? LogoAnimatedWidget(
                  size: 1.5,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    BarcodeWidget(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.width / 1.5,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      padding: const EdgeInsets.all(10),
                      // data: client!.phone,
                      data: base64.encode(utf8.encode(client!.phone)),
                      barcode: Barcode.qrCode(),
                    ),
                    // Text(base64.encode(utf8.encode(client!.phone))),
                    SizedBox(height: 60),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${client.firstName} ${client.lastName}',
                            style: GoogleFonts.abrilFatface(
                              fontSize: 26,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.edit,
                            size: 14,
                          ),
                        ],
                      ),
                      onTap: () {
                        // Navigator.of(context).push(
                        //   CupertinoPageRoute(
                        //     builder: (context) => EditNameView(
                        //       user: user!,
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                    SizedBox(height: 30),
                    SmallTitleWidget(
                      text: '998${client.phone}'.phoneFormatter(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ProfileCardWidget extends StatelessWidget {
  const _ProfileCardWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user!.firstName.isEmpty && user!.lastName.isEmpty
                  ? const _SimpleTextWidget(
                      title: 'Имя не указано',
                    )
                  : _SimpleTextWidget(
                      title: '${user!.firstName} ${user!.lastName}',
                    ),
              const SizedBox(height: 10),
              Text(user!.userName.phoneFormatter()),
            ],
          ),
          Positioned(
            top: 5,
            right: 5,
            child: TextButtonWidget(
              method: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => EditNameView(
                      user: user!,
                    ),
                  ),
                );
              },
              text: 'Изменить',
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCardWidget2 extends StatelessWidget {
  const _ProfileCardWidget2({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return _BorderContainerWidget(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user!.firstName.isEmpty && user!.lastName.isEmpty
                  ? const _SimpleTextWidget(
                      title: 'Имя не введено',
                    )
                  : _SimpleTextWidget(
                      title: '${user!.firstName} ${user!.lastName}',
                    ),
              const SizedBox(height: 10),
              Text(user!.userName),
            ],
          ),
          Positioned(
            top: 5,
            right: 5,
            child: TextButtonWidget(
              method: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => EditNameView(
                      user: user!,
                    ),
                  ),
                );
              },
              text: 'Изменить',
            ),
          ),
        ],
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

class _BorderContainerWidget extends StatelessWidget {
  const _BorderContainerWidget({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.white24,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
