import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user.dart';
import '../../../extensions.dart';
import '../../../theme/theme_details.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/hero_title_widget.dart';
import '../../../widgets/small_title_widget.dart';
import '../../business/settings_view/edit_name_view.dart';
import '../../select_type_view/select_type_view.dart';

class BarcodeView extends StatelessWidget {
  const BarcodeView({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.watch<ClientHomeViewModel>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        bottom: ThemeDetails.appBarDivider,
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<ClientHomeViewModel>().logout().then(
                    (value) => Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const SelectTypeView(),
                      ),
                      (route) => false,
                    ),
                  );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
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
                  data: user.barcode!,
                  barcode: Barcode.qrCode(),
                ),
                SizedBox(height: 60),
                GestureDetector(
                  child: HeroTitleWidget(
                      text: '${user.firstName} ${user.lastName}'),
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => EditNameView(
                          user: user!,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                SmallTitleWidget(text: user!.userName.phoneFormatter()),
                const SizedBox(height: 15),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
