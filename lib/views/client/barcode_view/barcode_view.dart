import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user.dart';
import '../../../utils/color_filter.dart';
import '../../../utils/constants.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/hero_title_widget.dart';

class BarcodeView extends StatelessWidget {
  const BarcodeView({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.read<ClientHomeViewModel>().user;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeroTitleWidget(text: '${user.firstName} ${user.lastName}'),
          // Container(
          //   // height: 200,
          //   width: double.infinity,
          //   // child: Co lorFiltered(
          //   // colorFilter: ColorFilterHelpers.invert,
          //   child: CachedNetworkImage(
          //     imageUrl: Constants.media + user.barcodeImage,
          //   ),
          //   // ),
          // ),
          BarcodeWidget(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white,
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            // color: Colors.white,
            padding: const EdgeInsets.all(10),
            data: user.barcode ?? '978020137962',
            barcode: Barcode.ean13(),
          ),
        ],
      ),
    );
  }
}
