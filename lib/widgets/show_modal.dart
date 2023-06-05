import 'package:flutter/material.dart';

import '../size_config.dart';

Future<dynamic> showModal(
  BuildContext context,
  List<Widget> widgets,
//    {
//   Color backgroundColor = AppColors.lightGray,
// }
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    enableDrag: true,
    // useSafeArea: true,
    isDismissible: true,
    isScrollControlled: true,
    // backgroundColor: backgroundColor,
    context: context,
    builder: (context) {
      return Padding(
        // padding: const EdgeInsets.all(10),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 10,
          right: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: getH(16)),
            const SizedBox(
              width: 40,
              child: Divider(
                height: 3,
                thickness: 3,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: getH(16)),
            // SizedBox(height: getH(22)),
            ...widgets,
          ],
        ),
      );
    },
  );
}
