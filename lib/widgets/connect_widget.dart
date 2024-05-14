import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';
import '../utils/helpers.dart';

class ConnectWidget extends StatelessWidget {
  const ConnectWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Связаться с нами',
            // style: GoogleFonts.inter(
            //   color: const Color(0xff575758),
            //   fontSize: 13,
            //   fontWeight: FontWeight.w500,
            // ),
            style: TextStyle(
              color: Color(0xff575758),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: getH(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Helpers.toWeb('t.me/tjm010', 'telegram'),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xff262629),
                ),
                height: getH(44),
                width: getH(44),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset('assets/svg/telegram.svg'),
                ),
              ),
            ),
            SizedBox(width: getW(8)),
            GestureDetector(
              onTap: () => Helpers.toCall('+998997034444'),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xff262629),
                ),
                height: getH(44),
                width: getH(44),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset('assets/svg/phone.svg'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
